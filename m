Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC035BDC2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147416; cv=none; b=IWobw0kjkV0pvcfI9FkYxqdx+m7XhR4ukjpezANFoR3DW5VCz42HdnLwPFtQRNd1BDvVVez3I9WNr1FY0XJfNQ/obLi3mH+NEgBx3R90cLsvS98zS0YlhefOvc7r+e+WmqKz4rSWQbdxmw5MtEOOW9bXhWMgvbJHH+esPnu2XN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147416; c=relaxed/simple;
	bh=zWpJNnNWzM2Ph+c0wHOs86Lzp7GeYwcc/x175foDYMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYSWJyH+OKL5SYvbwBNv4DU2MzYcYP84dGEMxNfEuH5s2qwF+DLnaavu/HPkCgQnjLT49bVGLXykdPgFPi77QCJnAqw4cB/TFRUxTljH70PZoKJfLsujGzjp0H/0UAdwPxpWBNZBsn8Fwm0bvFm5X/Sw2C/Gg8Fow+IyHxSRnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkFav48Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkFav48Y"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso798123b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147414; x=1775752214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSVpf2ocS61Yw+QFSIrS1uM0HP/azR2fnqKe25cEGDk=;
        b=NkFav48YGeocrWJ+h6Zwm3rsrNIAZveNLV3icbGP2vpBZide3hu1NEllh7zsvas+38
         px3hv0YNnkkPBBcJeaT8ivMqndw8LitZjQU8FzKbn3eoG8Yu/0jnc0M8eXq97GY/UF67
         lYIa4YWHfxqH7a+7LEOtXbDsNIIRdglp5IxI3t8FgFuxinqC1pnsXVVjoNiRnemz80sN
         hYW67QPJZaZZAsc3SQWembMWA7yRsgg8AeJU6x7cb/y83L+solXasmsB8NYoGTLf4jv/
         SriDxCuhp2HzBnJhrV8mdBBsWLW/NkU8VJ3zNwLr8tvImi5jM7IdmG0KW4ZCCsAP2Zo/
         pHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147414; x=1775752214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSVpf2ocS61Yw+QFSIrS1uM0HP/azR2fnqKe25cEGDk=;
        b=lLqLdXhiP5MrdSzIMzP2N32n8n+blcl/z9YcT5rYeFP643BClP26i1FtebKFtAj3gK
         vSGQF4Q8VIU+7vUILkHhAx20kxrzA2NpyK46LERg4yzYjZSrZh4dPiOChS/bu/wY4qky
         kwlnuS5pug3i5mZTFRMRSRTng/k9MjsFiCoSetqi4D/laYISiYPnazTJUJSaKDsxZDBq
         w0R3lBvXhBnvMn89WxzhEu2ClCBREW6TcdGF34JfwDfWS0sdeB/y+QX7MSUIP6Nj4LJV
         NG4+PPaT3SVQ8ijhd4eCciMcg1qNcYKysth+r+K1TgUzcxKEqxk4qPuneFUx56xkECrK
         e8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVG2xGVIy00yd8h6VPQsELp26uxFZOTH27f2Ou8Cvlj9UXRm1Emv1vFSm0oQaoxb4COJo8QmUzB1i4RPVHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDeNbBKMiy6QQXmltSr5sUMi7+f1XKAppdTdU9UaoAf2pTzhI
	TSeUsoyh9N8TXAYOAv/qmUC1WN0Y0Sfl8z1AVVgAPMi9wexgadb4hPhdADXpUA==
X-Gm-Gg: ATEYQzwA4I6kp0JoCFXKkCtBFrfAAWpJaIFdrpivShNQ+M77DT34M7UD7HNEgkuqB8S
	xEvwbJdkocFDhAvC9G6Nk1/4xjciqIFsWt/S9pH7uPozWdEc8B0WMEtuBeK6WQTAOrnfI0rM9yu
	SQOKZZefHeXs8UAJrbU6zABhv/rw8dX5zCzL25tChlfKFO6XzXefZOZVjRD2rPPGVIrNZdmLlxX
	0EiBTFN3l3U5ZVG7asIg9chTneeXdrlZ459SClDZVPvVbWDAYMfeiJGtxuwzqv2+3/wZGmtT505
	+hgc9MobqxZUGhDt+XqU4KRW3Ggip9boqA2U74X9vf9dbLCaLG3st8M/NUWE/ShC/4R550d0c76
	aP3kZVHBh+V45jCsmXdzcLOchXhkTOzBrpgJlnCLnfGUTFRlksy53LSve5iEpkUibuUL5/1VqRS
	dV1ck1m0C4aTkb82JvJA==
X-Received: by 2002:a05:6a00:3c86:b0:829:bd4d:3817 with SMTP id d2e1a72fcca58-82cfb8f134dmr4373749b3a.28.1775147414130;
        Thu, 02 Apr 2026 09:30:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm3774792b3a.40.2026.04.02.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Thu,  2 Apr 2026 09:28:40 -0700
Message-ID: <20260402162840.2989717-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for fuse over io-uring usage of buffer rings and
zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
index d73dd0dbd238..bc47686c023f 100644
--- a/Documentation/filesystems/fuse/fuse-io-uring.rst
+++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
@@ -95,5 +95,194 @@ Sending requests with CQEs
  |    <fuse_unlink()                         |
  |  <sys_unlink()                            |
 
+Buffer rings
+============
 
+Buffer rings have two main advantages:
 
+* Reduced memory usage: payload buffers are pooled and selected on demand
+  rather than dedicated per-entry, allowing fewer buffers than entries. This
+  infrastructure also allows for future optimizations like incremental buffer
+  consumption where non-overlapping parts of a buffer may be used across
+  concurrent requests.
+* Foundation for pinned buffers: contiguous buffer allocations allow the
+  kernel to pin and vmap the entire region, avoiding per-request page
+  resolution overhead
+
+At a high-level, this is how fuse uses buffer rings:
+
+* The first REGISTER SQE for a queue creates the queue and sets up the
+  buffer ring. The server provides two iovecs: one for headers and one for
+  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that maps
+  to a specific header slot.
+* When a client request arrives, the kernel selects a payload buffer from
+  the ring (if the request has copyable data), copies headers and payload
+  data, and completes the sqe.
+* The buf_id of the selected payload buffer is communicated to the server
+  via the fuse_uring_ent_in_out header. The server uses this to locate the
+  payload data in its buffer.
+* The server processes the request and sends a COMMIT_AND_FETCH SQE with
+  the reply. The kernel processes the reply and recycles the buffer.
+
+Visually, this looks like::
+
+ Headers buffer:
+ +-----------------------+-----------------------+-----+
+ | fuse_uring_req_header | fuse_uring_req_header | ... |
+ | [ent 0]               | [ent 1]               |     |
+ +-----------------------+-----------------------+-----+
+ ^                       ^
+ |                       |
+ ent 0 header slot       ent 1 header slot
+ (sqe->buf_index=0)      (sqe->buf_index=1)
+
+ Payload buffer pool:
+ +-----------+-----------+-----------+-----+
+ | buf 0     | buf 1     | buf 2     | ... |
+ | (buf_size)| (buf_size)| (buf_size)|     |
+ +-----------+-----------+-----------+-----+
+ selected on demand, recycled after each request
+
+Buffer ring request flow
+------------------------::
+
+|  Kernel                                  |  FUSE daemon
+|                                          |
+|  [client request arrives]                |
+|  >fuse_uring_send()                      |
+|    [select payload buf from ring]        |
+|    >fuse_uring_select_buffer()           |
+|    [copy headers to ent's header slot]   |
+|    >copy_header_to_ring()                |
+|    [copy payload to selected buf]        |
+|    >fuse_uring_copy_to_ring()            |
+|    [set buf_id in ent_in_out header]     |
+|    >io_uring_cmd_done()                  |
+|                                          |  [CQE received]
+|                                          |  [read headers from header slot]
+|                                          |  [read payload from buf_id]
+|                                          |  [process request]
+|                                          |  [write reply to header slot]
+|                                          |  [write reply payload to buf]
+|                                          |  >io_uring_submit()
+|                                          |   COMMIT_AND_FETCH
+|  >fuse_uring_commit_fetch()              |
+|    >fuse_uring_commit()                  |
+|     [copy reply from ring]               |
+|     >fuse_uring_recycle_buffer()         |
+|    >fuse_uring_get_next_fuse_req()       |
+
+Pinned buffers
+==============
+
+Servers can optionally pin their header and/or payload buffers by setting
+FUSE_URING_PINNED_HEADERS and/or FUSE_URING_PINNED_BUFFERS flags. When
+set, the kernel pins the user pages and vmaps them during queue setup,
+enabling memcpy to/from the kernel virtual address instead of
+copy_to_user/copy_from_user.
+
+This avoids the per-request cost of pinning/unpinning user pages and
+translating virtual addresses. Buffers must be page-aligned. The pinned pages
+are accounted against RLIMIT_MEMLOCK (bypassable with CAP_IPC_LOCK).
+
+Zero-copy
+=========
+
+Fuse io-uring zero-copy allows the server to directly read from / write to
+the client's pages, bypassing any intermediary buffer copies. This requires
+the FUSE_URING_ZERO_COPY flag, buffer rings with pinned headers and buffers,
+and CAP_SYS_ADMIN.
+
+The kernel registers the client's underlying pages as a sparse buffer at
+the entry's fixed id via io_buffer_register_bvec(). The fuse server can
+then perform io_uring read/write operations directly on these pages.
+Non-page-backed args (eg out headers) go through the payload buffer as
+normal. Pages are unregistered when the request completes.
+
+The request flow for the zero-copy write path (client writes data, server
+reads it) is as follows:
+
+Zero-copy write
+---------------::
+|  Kernel                                   |  FUSE server
+|                                           |
+|  "write(fd, buf, 1MB)"                    |
+|                                           |
+|  >sys_write()                             |
+|    >fuse_file_write_iter()                |
+|      >fuse_send_one()                     |
+|        [req->args->in_pages = true]       |
+|        [folios hold client write data]    |
+|                                           |
+|  >fuse_uring_copy_to_ring()               |
+|    >copy_header_to_ring(IN_OUT)           |
+|      [memcpy fuse_in_header to            |
+|       pinned headers buf via kaddr]       |
+|    >copy_header_to_ring(OP)               |
+|      [memcpy write_in header]             |
+|                                           |
+|    >fuse_uring_args_to_ring()             |
+|      >setup_fuse_copy_state()             |
+|        [is_kaddr = true]                  |
+|        [skip_folio_copy = true]           |
+|                                           |
+|      >fuse_uring_set_up_zero_copy()       |
+|        [folio_get for each client folio]  |
+|        [build bio_vec array from folios]  |
+|        >io_buffer_register_bvec()         |
+|          [register pages at ent->id]      |
+|        [ent->zero_copied = true]          |
+|                                           |
+|      >fuse_copy_args()                    |
+|        [skip_folio_copy => return 0       |
+|         for page arg, skip data copy]     |
+|                                           |
+|    >copy_header_to_ring(RING_ENT)         |
+|      [memcpy ent_in_out]                  |
+|    >io_uring_cmd_done()                   |
+|                                           |
+|                                           | [CQE received]
+|                                           |
+|                                           | [issue io_uring READ at
+|                                           |  ent->id]
+|                                           | [reads directly from
+|                                           | client's pages (ZERO_COPY)]
+|                                           |
+|                                           | [write data to backing
+|                                           | store]
+|                                           |  [submit COMMIT AND FETCH]
+|                                           |
+|  >fuse_uring_commit_fetch()               |
+|    >fuse_uring_commit()                   |
+|      >fuse_uring_copy_from_ring()         |
+|    >fuse_uring_req_end()                  |
+|      >io_buffer_unregister(ent->id)       |
+|        [unregister sparse buffer]         |
+|      >fuse_zero_copy_release()            |
+|        [folio_put for each folio]         |
+|      [ent->zero_copied = false]           |
+|      >fuse_request_end()                  |
+|        [wake up client]                   |
+
+The zero-copy read path is analogous.
+
+Some requests may have both page-backed args and non-page-backed args.
+For these requests, the page-backed args are zero-copied while the
+non-page-backed args are copied to the buffer selected from the buffer
+ring:
+  zero-copy: pages registered via io_buffer_register_bvec()
+  non-page-backed: copied to payload buffer via fuse_copy_args()
+
+For a request whose payload is zero-copied, the registration/unregistration
+path looks like:
+
+register:  fuse_uring_set_up_zero_copy()
+	     folio_get() for each folio
+	     io_buffer_register_bvec(ent->id)
+
+[server accesses pages via io_uring fixed buf at ent->id]
+
+unregister: fuse_uring_req_end()
+	      io_buffer_unregister(ent->id)
+	      -> fuse_zero_copy_release() callback
+		 folio_put() for each folio
-- 
2.52.0

