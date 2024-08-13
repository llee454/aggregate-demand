;;; ----------------------------------------------------------------------
;;;    unit test
;;;    Copyright (C) 2003 Richard Todd
;;;    Copyright (C) 2024 Maxim Cournoyer <maxim.cournoyer@gmail.com>
;;;    Copyright (C) 2024 David Pirotte <david@altosw.be>

;;;    This program is free software; you can redistribute it and/or modify
;;;    it under the terms of the GNU General Public License as published by
;;;    the Free Software Foundation; either version 2 of the License, or
;;;    (at your option) any later version.
;;;
;;;    This program is distributed in the hope that it will be useful,
;;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;    GNU General Public License for more details.
;;;
;;;    You should have received a copy of the GNU General Public License
;;;    along with this program; if not, write to the Free Software
;;;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;;; ----------------------------------------------------------------------

(use-modules (unit-test)
             (logging logger)
             (logging port-log)
             (ice-9 textual-ports)
             (oop goops))

(define* (call-with-temporary-file proc #:key (mode "w+"))
  "Open a temporary file name and pass it to PROC, a procedure of one
argument.  The port is automatically closed."
  (let ((port (mkstemp "/tmp/file-XXXXXX" mode)))
    (call-with-port port proc)))

(define-class <test-logging> (<test-case>))

(define-method (test-log-to-one-port (self <test-logging>))
  (let* ((strport (open-output-string))
         (lgr     (make <logger> #:handlers (list (make <port-log> #:port strport)))))
    (open-log! lgr)
    (log-msg lgr 'CRITICAL "Hello!")
    (assert-equal "CRITICAL: Hello!\n"
                  ;; skip over the time/date, since that will vary!
                  (substring (get-output-string strport) 20))))

(define-method (test-log-to-default-logger (self <test-logging>))
  (let* ((strport (open-output-string))
         (lgr     (make <logger> #:handlers (list (make <port-log> #:port strport)))))
    (open-log! lgr)
    (set-default-logger! lgr)
    (log-msg 'CRITICAL "Hello!")
    (set-default-logger! #f)
    (assert-equal "CRITICAL: Hello!\n"
                  ;; skip over the time/date, since that will vary!
                  (substring (get-output-string strport) 20))))

(define-method (test-log-to-registered-logger (self <test-logging>))
  (let* ((strport (open-output-string))
         (lgr     (make <logger> #:handlers (list (make <port-log> #:port strport)))))
    (register-logger! "main" lgr)
    (log-msg (lookup-logger "main") 'CRITICAL "Hello!")
    (assert-equal "CRITICAL: Hello!\n"
                  ;; skip over the time/date, since that will vary!
                  (substring (get-output-string strport) 20))))

(define-method (test-log-with-source-properties (self <test-logging>))
  (let* ((strport (open-output-string))
         (lgr     (make <logger> #:handlers (list (make <port-log> #:port strport))))
         (source-properties '((filename . "unit-tests/logging.logger.scm")
                              (line . 62)
                              (column . 4))))
    (open-log! lgr)
    (log-msg lgr source-properties 'ERROR "Hello!")
    (assert (string-contains (get-output-string strport)
                             " unit-tests/logging.logger.scm:63:4: "))))

(define-method (test-log-with-flush-on-emit-disabled (self <test-logging>))
  "Test the case where flush-on-emit? on the handler is false."
  (call-with-temporary-file
   (lambda (port)
     (setvbuf port 'block 1000000)      ;large 1MB buffer
     (let ((lgr (make <logger>
                  #:handlers (list (make <port-log> #:port port
                                         #:flush-on-emit? #f)))))
       (log-msg lgr 'ERROR "this should be buffered, i.e. not written yet")
       (assert (string-null?
                (call-with-input-file (port-filename port) get-string-all)))))))

(define-method (test-log-with-flush-on-emit (self <test-logging>))
  "Test the default case where flush-on-emit? on the handler is true."
  (call-with-temporary-file
   (lambda (port)
     (setvbuf port 'block 1000000)      ;large 1MB buffer
     (let ((lgr (make <logger>
                  #:handlers (list (make <port-log> #:port port)))))
       (log-msg lgr 'ERROR "this should be flushed to disk after emit")
       (assert (string-contains
                (call-with-input-file (port-filename port) get-string-all)
                "this should be flushed to disk after emit"))))))

(exit-with-summary (run-all-defined-test-cases))
