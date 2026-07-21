Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E103BF69A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624123; cv=none; b=Y0hLjkyZkw71dUOQBIrZUPcjo5wp0d2nPMpC0g9BOGrxDcIq4xNUyuEz/5lXYc/jO+gSnXi8iW4OEAG9dsmNumhjmPlLKvVTz+0qNhD461pySBywa0vk1PimlKbN+NkqS1xtt++ovyFqXccCAtGmKhXcHi+gjb/kjA75O4xg3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624123; c=relaxed/simple;
	bh=9v45zTVeTCX7fIaTjQSky2XyjxWftJs8YLfqZCwJ++k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKNQLPPpli1Kh3l+dbBb+ClHrWTN50ilga9+jWg9bnh0NaOIO2iNES74eaC60CxHr4p7oNFJVvDeT6BK/4mSXvcjcqdioWLr94FOacM0xA8o+JjLfeAsSRqBwj0vJ3OS3xziizPWBgRM/nUzlIqrRxG54zs4fX/w+U/5JeIQsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKqY95Ei; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKqY95Ei"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso7502340a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624121; x=1785228921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvFeyjLJ8AJSuF4p/D9KBNAj9grUIgBOggYUeLP/dVM=;
        b=gKqY95EiR6hjrSnIVln9pht6Gh9eQF1Q3vnjxSPMY64eXN1mAHIy9xrv/8VEWDs6bQ
         aMyZYoRuJW6aUjCpfF2BFNnHO1KqRZOV2yAhWLoa6SQ3pj9bUMemkGi7z6qrpftw9cPE
         mTGbfitG9kO/ecCWZ3Loeqm6M+LD6GKBiaGgyHRvG5xePYQ4yI7IoMHDJVpFmns2F1QE
         p24ICSBM1FIFCVOxVp2E+nUik9XnrBVVLwJ8SRX3cbV1muRFV/YdNCpTU9SQqSffxCfk
         jl7nq1i0x8u06B8A0HzapnV2o97C1GIurSeyGrXH/c3BO+Cj0eMq1RhtdOzj1pr3eI/S
         E+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624121; x=1785228921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvFeyjLJ8AJSuF4p/D9KBNAj9grUIgBOggYUeLP/dVM=;
        b=VZPqLZiKQb78WUA/ppU+NRwsNJPQjeKEjhWCV+8xMfDDEmAz9QdzyaS9D0uB1mEahA
         zOAeKWAqWq48RAIKJNIwJMVcGJHDQaePIvsYJEzTNdtzP/RPz/xuP+1whUmkbEJlO86b
         J9L1FPfpTpR8Zpt9C3TMLVbW/Zi8noWeYPTlmIuUDItSV4rWqQmycSSV4BK6nONgSMbR
         DphAICg+JtAxksLgMJJErwhuKfdpZpaf9Xo+sNz/51XlXt4K12mE7gcQr/DvPXIvLg3Z
         Uw26FRLe5v5dJ8vCzGLB839hsxifpnnpm4KcnH0xZQ3CkcVJxRfhRH2yUctAFgi3paW9
         YB/w==
X-Forwarded-Encrypted: i=1; AHgh+RpreIEoNjfOfCqZKwvh/8Iq1bJVp/u0ArXBDD+oqGZi9n0s78ULV+ArdbS7piV/yWuKzi6xDPpnTDr7njyR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66iMUor8int4dkp6EJyGKfZCsq8bDF20OePblxyka5GWz8+8A
	ceaoIK1RS3ySJfKSioLTZYCJ7EiudKcGyId+xawis2Nk4okogzh6YnaHnx6dfsuu
X-Gm-Gg: AfdE7cn0OOcai9N8fx8znnupikI6KKy4F53h9w3wqYR+nYfcIdAHt3c/+cIEbU1UhHn
	CYN03SDRRE3h02O8AyvBqSOuvBw9RJ6IyCFZl+WPSd9knkhV9xFcKvfRvG4FFsH+3BkoPVF6wGz
	mPNxpKH5oZRC8nVvtjlHx6htAOuQAyhz3/aaOZCvelQmez49y5XxIf4n4sB6QDVZCshW0T1zNko
	lkrxSO4jQs+ojTFbjh1LntMiiWDnpTcnGGcYWvOVJsxH4/vqesP7Q9Y+CrOIdNkDnXeLx26LTXM
	B72ZOdBpGg/4z0MoFaS3+y6/yjlLCY5bU324WUyhp75XFytw7vwXq3KqYtI32TBkizHQuonPpOX
	fwXP8q++eTZ95heIAk4QdrbpDo1z9GuVEo6/SqDRYkw5Jub5J8lik5iC94V/Tb7hPXtJQB36POY
	bN0dIhK4frn+axlnDzC1bZbJoTdTGSkLn7DzWYOmSgk4O73bsu59LtaoUa+Pm69Tc/Y5BqAUcZh
	O6tA7QwEHtprb69eVCaGNuwxSNV30Zmr1I1jbg8/78N0HixkgBUdlobqrMTkG5cWhv3tiFMxDBN
	Wf1VBhrhnQ==
X-Received: by 2002:a05:6a21:4c0e:b0:3c3:89cf:f43 with SMTP id adf61e73a8af0-3c3ad7aa401mr18624035637.30.1784624120976;
        Tue, 21 Jul 2026 01:55:20 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.z168d0f9edf9bc766-tp.internal (8.99.126.34.bc.googleusercontent.com. [34.126.99.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm45463137eec.0.2026.07.21.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:55:20 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v2 0/2] io_uring: add fremovexattr and flistxattr support
Date: Tue, 21 Jul 2026 08:54:56 +0000
Message-ID: <20260721085458.2716-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series completes io_uring's FD-based xattr operations by adding
support for:
- IORING_OP_FREMOVEXATTR
- IORING_OP_FLISTXATTR

This allows asynchronous xattr removal and listing. Support is restricted
to FD-based operations on registered files to avoid path lookup overhead.

Corresponding test suite modifications have been integrated into the
official liburing test suite (test/xattr.c) and verified to pass
successfully. A corresponding liburing patch implementing these prep
helpers, sanitizers, and test cases is following this kernel series.

- Patch 1 makes the necessary VFS-layer list/remove helpers non-static
  and declares them in fs/internal.h.
- Patch 2 implements the io_uring operational support (opcodes, opdefs,
  preparation, and issue handlers) and invokes these exposed helpers.

Changes since v1:
- Omit path-based opcodes to prioritize optimal FD-based variants.
- Limit exported VFS helpers to only file_listxattr and file_removexattr.
- Rewrite standalone test program into a standard liburing testcase.

Aditya Prakash Srivastava (2):
  fs: make file_listxattr and file_removexattr helpers non-static
  io_uring: add fremovexattr and flistxattr support

 fs/internal.h                       |  2 +
 fs/xattr.c                          | 10 ++--
 include/uapi/linux/io_uring.h       |  2 +
 io_uring/opdef.c                    | 18 +++++++
 io_uring/xattr.c                    | 74 +++++++++++++++++++++++++++++
 io_uring/xattr.h                    |  6 +++
 tools/include/uapi/linux/io_uring.h | 13 +++++
 7 files changed, 119 insertions(+), 6 deletions(-)

-- 
2.47.3
