Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300A3C65FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392394; cv=none; b=N3bsJMo7n2FN4QCTxJVbMkIfQDmxl+KJuiZyjezUrx3GZN1M5RusRSyDaSsOFixQQHyo+uFUS8209esxAMI6Ekc0rDyLEMY2A5SQamSn8WM7SM7MtY8ab39cJjcaMghubIUZ1lZF51o7SX1+d3wiV3BJt7lSV0KitN49gKkcmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392394; c=relaxed/simple;
	bh=mzZrEPMr2KfyhFn29hqt8vrz9lXjWfl3plgfGSQRF4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxrEFhKs144uMAiJTkKg+ypntUQ3nsfl3QHFAdmE1/8Jg8WejpXkyhT/z8H3IYu9tBkq45Ch6eaFdvKSkVgf3c2sVN9wD5Pc2I5Hr74E59Jyq5XfM75d2IdWNWPF5wq5mzu56LXEcXv2/ycAtxRyJEyZ5YEMpc1zdzy8H96nZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skHIO30t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skHIO30t"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b06d33e84cso11219035ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392392; x=1774997192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1oIF/W7SrWgo8HJzdvEVExtAMOD+QnP/C8/FaeLK2s=;
        b=skHIO30tuVamZcZ1KqGzu42afeKMKFDJIHgMqQb74BJzg3eU+aTrI796VI68QDxWG8
         /aZM/eGyfFtzB0tXfm25Ec2F3rMboGKtNgRlNp0yxS7Bu3EQRYa61Mr1zgrV8240SVTq
         vfvBVRpb6gS5+8bmFezNGUblJ3eq/kQTOGFlozO7zdTCLRQNlyuxQC40T6EeaBJTweRV
         kWgUu2iRKiBVenoszeGA2f9DDMmHfSfDWtdkLVX5Ry8dETU6MrdnsWb5ryBcfI1YKUya
         9kLn34MslyKxJEbwF5jTxDAnjNv/dRmGRmiYKyImNNefmk1t0KABVya2uttMFU72pZ24
         jOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392392; x=1774997192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1oIF/W7SrWgo8HJzdvEVExtAMOD+QnP/C8/FaeLK2s=;
        b=LuPTunihRH9hMD/hRC5oKxJfHgcAVdIBkFvaYTr32TOOf26Ytx9yezKPJf1zGJwcNO
         WjC5C+ZKclzwnUyc8zRxKrjZAJNXtdNtt9vibRK3nDM0ntsNegz3Y4RMcW0oYBLoO9PU
         DGBlXOfL8MD8vwgpiLt87J/IY+O7OAdv5Y5pAyj8BNKxHTkftoqpFVCENVl9atwz726D
         LpiYEx34PSKCzUL7NphBwm5J8abWUTWH/Vli+wMpqXC2wJ0G1cA1ZjQa9rGtiJutWz6I
         rb5xZKvp/JsFZDphVvIIta4pBmX5BcS8epULn1Y+yv9kZupcfp+T5ViCaP4qSM744siF
         Rj4A==
X-Forwarded-Encrypted: i=1; AJvYcCVI6dAYrgbFD1YEE2JX/OAPXoJyKrrBfPTBYEj1FTVo/fUWZdasM1y3GcCRGPbRD0y8uFettkGwE+pjRmjr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrihgt0Y1YGI8RvRfyPsyVyvHxYvH//17C+kJcrpUFCGhMGSz0
	zZONII/qeLiIkFVeATTV4+cyC0c+1QtNKVk4UzjPorLs7vfQytvUAqYy
X-Gm-Gg: ATEYQzzFJ5+IMBi0UeogHl5Kj9/jyFRN5uFHJNgL8VWBFa4sO+pWOfZeY7rdMKGs0lp
	jcDIluS5UYA+M5iR63s7mFPLeYtoOFcptJ0oTOPFX5MsuGK+7fnANpkdzwqXAv0RN+EcRQ2c0EG
	TNV5im3mCuCEUXfer+xGKs1wObk0SpgNw1M1soqytsjzxma3aDgUno2b7AhfoPoTmnmvh4D1pdB
	l3ozqPzWM/Rxiq2q4IY3LeshPf8C6gRgrtva1BkVO9IoTeVbPoBn6NtGbX0G4zWI3NAQf1btAjW
	WOAlLK1qkuENf6c6RR+cob9C10kZrrrRi42QhNvuMkD55wNNcVbf5yxAc5u3y48XRLykpCvcbom
	q7GOjX1m4VDUIL2J5AdRRxU+G+uI+vhYOwY+vW69+WJyG/RbR4B3mZvHXZ/ykTmpZCxDDOocfKv
	irc1iDjMDU0Ndc/TJ1WA==
X-Received: by 2002:a17:903:24e:b0:2b0:71da:4ed7 with SMTP id d9443c01a7336-2b0b0ab5063mr12283515ad.25.1774392391990;
        Tue, 24 Mar 2026 15:46:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0b303c81esm2161415ad.38.2026.03.24.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 9/9] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Tue, 24 Mar 2026 15:45:32 -0700
Message-ID: <20260324224532.3733468-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324224532.3733468-1-joannelkoong@gmail.com>
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for fuse over io-uring usage of kernel-managed
bufrings and zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/fuse/fuse-io-uring.rst        | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
index d73dd0dbd238..f2522541e4ba 100644
--- a/Documentation/filesystems/fuse/fuse-io-uring.rst
+++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
@@ -95,5 +95,64 @@ Sending requests with CQEs
  |    <fuse_unlink()                         |
  |  <sys_unlink()                            |
 
+Kernel-managed buffer rings
+===========================
 
-
+Kernel-managed buffer rings have two main advantages:
+
+* eliminates the overhead of pinning/unpinning user pages and translating
+  virtual addresses for every server-kernel interaction
+* reduces buffer memory allocation requirements
+
+In order to use buffer rings, the server must preregister the following:
+
+* a kernel-managed buffer ring
+* a registered memory region large enough to hold the headers for the ents
+
+Please refer to libfuse's lib/fuse_uring.c for an example of how to set this
+up.
+
+At a high-level, this is how fuse uses buffer rings:
+
+* The server registers a kernel-managed buffer ring. In the kernel this
+  allocates the pages needed for the buffers and vmaps them. The server
+  obtains the virtual address for the buffers through an mmap call on the ring
+  fd.
+* When the server creates a queue, it passes in the headers offset, which
+  specifies the offset into the registered memory region where the headers
+  reside.
+* When there is a request from a client, fuse will select a buffer from the
+  ring if there is any payload that needs to be copied, copy over the payload
+  to the selected buffer, and copy over the headers to the registered memory
+  region. Each ent has its own id (passed through sqe->buf_index at setup
+  time) that communicates where in the memory region the headers for that ent
+  resides.
+* The server obtains a cqe representing the request. The cqe flag will have
+  IORING_CQE_F_BUFFER set if a selected buffer was used for the payload. The
+  buffer id is stashed in cqe->flags (through IORING_CQE_BUFFER_SHIFT). The
+  server can directly access the payload by using that buffer id to calculate
+  the offset into the virtual address obtained for the buffers.
+* The server processes the request and then sends a
+  FUSE_URING_CMD_COMMIT_AND_FETCH sqe with the reply.
+* When the kernel handles the sqe, it will process the reply and if there is a
+  next request, it will reuse the same selected buffer for the request. If
+  there is no next request, it will recycle the buffer back to the ring.
+
+Zero-copy
+=========
+
+Fuse io-uring zero-copy allows the server to directly read from / write to the
+client's pages and bypass any intermediary buffer copies. This is only allowed
+on privileged servers. Access to these pages (eg reads/writes by the server)
+must go through the io-uring interface.
+
+In order to use zero-copy, the server must use kernel-managed buffer rings. It
+will also need to preregister a sparse buffer for every ent in the queue. This
+is where the client's pages will reside.
+
+When the client issues a read/write, fuse stores the client's underlying pages
+in the sparse buffer entry corresponding to the ent in the queue. The server
+can then issue reads/writes on these pages through io_uring rw operations.
+The pages are unregistered once the server replies to the request.
+Non-zero-copyable payload (if needed) is placed in a buffer from the
+kernel-managed buffer ring.
-- 
2.52.0

