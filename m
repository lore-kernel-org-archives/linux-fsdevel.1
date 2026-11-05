Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884710;
	b=ORww8KuCy8y3CsybF1Qem9K6FOjLiAyCDgTM4KZMI4QNZBa2AftPlX/CA5QL56gLVbeQ
	 oKIB33TFOpB+5tdhp3kag38wmwbRKJjEONw/x3n9G8XVSCpXhYDe0OZkb913LHwt0fC5d
	 p29r5IV34Akr3ZzlRnGrpEA2tM1eLnV/YPG/gyB+Cft0RrJGc4oqeDc6CgLlM1mb1Un0p
	 clweYUFpp2KIV0cKk7pS7+pHqTxAEYq9WQ89d6l1izJ6YeQX4KGWAROzUJIZayqbBtOGm
	 5FI/AXSvDCGvMYqjGHrFVMVktGQgETvE6HvB6OucTaBAIKEMBbWGlh4B6BWBgE+/v5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884710;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DXlALzxYM36/ki6riHR/Kh9IQJCV3TdTeTCjVtxynx8=;
	b=aSSCGTtA0gHUzeiZNCLgzgrT3RV+KJ8/QnH/ONkICpkzo1ljDQns1r2UkJbxLn2/CSmY
	 QGgUBbcGvceSW0vO1w62qiX046bGQx1GSYofz6pc+U9juw/+vTFXMsr/Qdh7nc3B050I4
	 1ltti3SPafsxaZ/Cb9Z+ryZSR00AUPSLVXPtfftbmMrbKvP/SdZ1T6lDp9KbVytWyjRJa
	 Qdokp8NABzSEbMI/ckPeZVfZs7/yHkz3IfaP/8mzoFNIYNARTOG9W4qU9EUKjAGPfSKV5
	 mEhLovQw+MFRH8y3SMDgzQW4dXf5/7O56wbpJjmT4ezKfRTR/JHsbm47ALmmpdhayTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YISs77ka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF6606A32F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YISs77ka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6C1F000C1;
	Thu,  5 Nov 2026 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884710;
	bh=DXlALzxYM36/ki6riHR/Kh9IQJCV3TdTeTCjVtxynx8=;
	h=From:Subject:Date:To:Cc;
	b=YISs77kamgloteawqYJQp+bNdsHDHN+jZn2J9ygjQZu3xafXEuFxyEgoxcFN5tJOb
	 FFXE6BMjAcxUJy07g/CNd1csKd2kWTkyFdWCSMZL+QCzLBgAeLm5OHZXL9JiNgQACt
	 P9rJiETpqHPNqtxLmOilD1sXTV6rl68xxw69AcdL7GIBVzxKo9tD91sUmXpuUpW0SG
	 rUnQYku9heHgkmZJaa4sdgiXdMz0t+x48VEjWvf02ycFtBal7OXIqH9WeM0VGuxov8
	 DTdt7KzBQe9ABzmsQaL0t/0H4zwMYKSEcT8mvhTvs3A+12K8o4Nx3B7r934AcX7dSg
	 1x1g3u5RWnQrQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] file: fix and document ordering for lockless fd lookup
 wrt to file_ref
Date: Thu, 05 Nov 2026 14:18:04 +0100
Message-Id: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWM2woCIRCGX2WZ60ZUqKBXiQh1xt2p0NBOsOy7p
 8Vefv/hm6FyEa5wGGYo/JIqOTUwmwHC5NLIKNQYrLY7Y/QW37lcMcqNz4Uj5kLtn0bUmiiQ3ft
 oCdr53lr5/MTH05/r0184PLqtL7yrjL64FKYeda9avWr1qr6CZfkCtSI87KgAAAA=
X-Change-ID: 20261105-work-file_ref-ordering-00ddcd27bf2d
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SRr/sYpJYJo+IfNOvY6pbJNLj3wgx53i0Llw4tQazxI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aZL+/W4X24fJtvEBq6ZpBIfbHLhoNPOwk9Me+0WLf
 S5em+Vl1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFBaGPzzFhar/Vl8KZNr/
 xHquoGV73fnvzxVmiNwQjp6yfN6CguUMf7gtQ6yW+M6eq310omNawTsZt11N3SrL/Rtu7nNb8s1
 hFjMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I went through include/linux/file_ref.h and its lockless users with a
TLA+ model and a set of LKMM litmus tests:

__fget_files_rcu(), __get_file_rcu(), fput() and file_ref_put_close()
against close(), open() and the SLAB_TYPESAFE_BY_RCU recycling of the
file. The protocol itself is fine but there are a few minor things:

* __fget_files_rcu() lost the dependency on its reload in
  253ca8678d30 making it possible to see f_mode and f_op from an earlier
  lifetime of a file on arm64 and power.

* file_ref_get() only needs acquire ordering. The reload has to be
  ordered after the increment. This is all we need.

* Add some missing documentation why we need full ordering during put.

This also adds litmus tests for this stuff. Here are the numbers after
this series:
                       instructions        cycles
    fcntl(F_GETFL)      457 -> 463    217.6 -> 218.1
    fstat()            1052 -> 1058   455.4 -> 454.1
    poll(), 16 fds     2394 -> 2458   828.7 -> 833.4
    pipe write+read    2261 -> 2271   925.1 -> 913.0
    unix socketpair    3269 -> 3277  1202.3 -> 1184.8
    io_uring_enter()   1036 -> 1038   284.6 -> 286.5
      registered file   942 -> 942    262.6 -> 263.2
    open()+close()     4277 -> 4277  1365.7 -> 1334.7
    dup()+close()       869 -> 873    525.1 -> 520.5

It's all within noise in terms of performance.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (5):
      file: depend on the reloaded pointer in __fget_files_rcu()
      file_ref: use acquire ordering in file_ref_get()
      file_ref: document why file_ref_put() stays fully ordered
      Documentation/litmus-tests: add the file reference count tests
      Documentation: update the lock-free file lookup in files.rst

 Documentation/filesystems/files.rst                | 48 +++++++++-----
 Documentation/litmus-tests/README                  | 57 ++++++++++++++++
 .../fs/file-ref-get-acquire-recheck.litmus         | 66 +++++++++++++++++++
 .../fs/file-ref-get-relaxed-recheck.litmus         | 50 ++++++++++++++
 .../fs/file-ref-put-full-handoff.litmus            | 76 ++++++++++++++++++++++
 .../fs/file-ref-put-release-handoff.litmus         | 66 +++++++++++++++++++
 .../fs/file-ref-reload-dep-field.litmus            | 74 +++++++++++++++++++++
 .../fs/file-ref-reload-nodep-field.litmus          | 59 +++++++++++++++++
 fs/file.c                                          | 42 +++++++++---
 include/linux/file_ref.h                           | 21 +++++-
 10 files changed, 528 insertions(+), 31 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261105-work-file_ref-ordering-00ddcd27bf2d

