Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1033A3E67
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392388; cv=none; b=A0WCWQli0xjNAOJX/V8jPe8W2Khg618+ZCcgDqlsBA1a3ynKYOuSIca5CxAbfMKImxCrcmp+wIQ5ZtUXjO5xDOnr4eP0XQWui17FbXjqSgs1GVJk4oHowWAfAOJm7Z427W3YYEk40AvfqItI7mxTaRuLmT+7FhzAZpplL5u1/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392388; c=relaxed/simple;
	bh=U2wWLNtpTlhxi6fdt3PXR/AnJJjXCtZZsTO5zRRfd7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8lV/oGWZo1nuHkXVLYfxYjm4zNj9blB3+oZ5G63M8htEkCHi9KYdx1/HbJddYBSaWs5l8BOVx8CRgHqfQbUeBPcfrkklLgRRWESXPcHZyWhY9NNokCzl2fWHYW9P4C2hQP4hLlm0GSB2J8ARgCscwJMMxxUa/ZfRGcqhKrwNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5IbR25G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5IbR25G"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab232cc803so19752655ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392387; x=1774997187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTuD3THT1XeALSRGGqprX5ybtuCzD8qFBJc+lnQ2hGc=;
        b=E5IbR25GHqXBVWimM+XxV9dByHjs9ccJOyjbUIHxDHGReh0mWnk00Z2D3Z3VS5CA5o
         uLQfY+qOaw4g4NA3m/ymB0KzpDNBRsLz5uOMBvAsuUJRAPZSHASHF2b79hq7SG3UtyOx
         Lno3QjtyJIGnnjNJTjA7MVCPMYoom63jIdR9FQpMUexILPjmR4IOF6y081Ac+4ZbHAV5
         RvmJlfnxX6RaunjYGJMHlNUpr1XFD1P7XrvCTY3MTEAabUPCWyXBFyAfSSraiBgGsMwL
         U6QpS4+TUUC+9aW4pwoLhQvM93wBALrKI9EUmbLOovaQLiSIF7locf7x2x7lpZCAE9h9
         pv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392387; x=1774997187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTuD3THT1XeALSRGGqprX5ybtuCzD8qFBJc+lnQ2hGc=;
        b=hR9Z32PTCdem5odoukAPZKJ8RUldYP27J2zIMJeUhHTyiY5MX49+Oxe6lBX1I7zraL
         hzMjyYrQ3uEIOlsye4+PL+SJur4ZZNyrWH9IGyVeuTTcwZZ4McgQwIGID52C3myZ3I3B
         ba6p9bMGVzXlKkrIUiDRsZLAxKZhaRi8aBHIJmkJQJswT1hnQwZd1oKOyxrXssaE27+y
         tz6YP3r5rzFi1IkTNWlTp0+XKMd9/7+5SlKytRrTsTz5zfQSW1HA8Ies/f1qba9yFNlw
         i6n7/EiQUxljaYXp53vgoSA0jb8asxoZhH2nES+b22Oo4QsFDB4IpgN0Mj6TWYa13POi
         mttw==
X-Forwarded-Encrypted: i=1; AJvYcCWJtNJiuKqX4I1hvoGnkQB7PZlYFJDpjzEDyU2BCzzKItMninfCPNGcnrB3X4IHiXbZ6an55jAx/LxKmMGC@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMSAykmmo7Z3o/YK8u7hN1rFGefPngMapj8PlVIOg0iiYRH2E
	TUXaQgdzTaIYsAbacj3baKLANtZpMlWH02fexs19aq5zB22vxt80BczA
X-Gm-Gg: ATEYQzztSeI1P/m2M9T3s5eDb0WgQvjojYeW9k9BfPsYiUxAYoeZuJ5N4ddVf6kZCjX
	eLM6pJaYXwlngfAHClPSJnCSWwQbq3S92BMY155C/QyOSph6ebQuBU2HiJxugvpOM7T1rccRtKd
	O6L+2axa+RXr7PdKPZ007eIt7xmlJIjsAWG5CE7FAHrd2ObarYH5J+sAbD4NYHLaO2uzPVY4Uw+
	ofUEjAO4NezbJlyTM7rkKkzW2mQfzezgAU8pK7JsgXV9BF9Lai+reI0/g+BL8xqfCV03H+3a/EV
	Blbn59knQ8Dkd8ZxEg+I+bc9qSA7vMtJ/hYBnXSJuQr7MV8fdqlRPIV6MSeKRkU0rC9/vRrI/IK
	uQHj6WODDene5sgESS8jE3Knoq+V8JW1lCF14kCH/S8wAe4CAGdIS/YrvBZPGnS8ZvQwZSmAfyX
	JzW7HOm3x5DT+FNS4WpA==
X-Received: by 2002:a17:903:3c2b:b0:2ae:c816:ec5d with SMTP id d9443c01a7336-2b0b0a8d27cmr13402205ad.32.1774392386972;
        Tue, 24 Mar 2026 15:46:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083549f63sm153492635ad.30.2026.03.24.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v1 6/9] fuse: support buffer copying for kernel addresses
Date: Tue, 24 Mar 2026 15:45:29 -0700
Message-ID: <20260324224532.3733468-7-joannelkoong@gmail.com>
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

This is a preparatory patch needed to support kernel-managed ring
buffers in fuse-over-io-uring. For kernel-managed ring buffers, we get
the vmapped address of the buffer which we can directly use.

Currently, buffer copying in fuse only supports extracting underlying
pages from an iov iter and kmapping them. This commit allows buffer
copying to work directly on a kaddr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
---
 fs/fuse/dev.c        | 25 +++++++++++++++++++------
 fs/fuse/fuse_dev_i.h |  7 ++++++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..7fee4ff64348 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 /* Unmap and put previous page of userspace buffer */
 void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+	if (cs->is_kaddr)
+		return;
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -873,6 +876,11 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 	struct page *page;
 	int err;
 
+	if (cs->is_kaddr) {
+		WARN_ON_ONCE(!cs->len);
+		return 0;
+	}
+
 	err = unlock_request(cs->req);
 	if (err)
 		return err;
@@ -931,15 +939,20 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+		void *pgaddr, *buf;
+		if (!cs->is_kaddr) {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		} else {
+			buf = cs->kaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
-
-		kunmap_local(pgaddr);
+		if (!cs->is_kaddr)
+			kunmap_local(pgaddr);
 		*val += ncpy;
 	}
 	*size -= ncpy;
@@ -1127,7 +1140,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 	}
 
 	while (count) {
-		if (cs->write && cs->pipebufs && folio) {
+		if (cs->write && cs->pipebufs && folio && !cs->is_kaddr) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -1139,7 +1152,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 			} else {
 				return fuse_ref_folio(cs, folio, offset, count);
 			}
-		} else if (!cs->len) {
+		} else if (!cs->len && !cs->is_kaddr) {
 			if (cs->move_folios && folio &&
 			    offset == 0 && count == size) {
 				err = fuse_try_move_folio(cs, foliop);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..aa1d25421054 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -28,12 +28,17 @@ struct fuse_copy_state {
 	struct pipe_buffer *currbuf;
 	struct pipe_inode_info *pipe;
 	unsigned long nr_segs;
-	struct page *pg;
+	union {
+		struct page *pg;
+		void *kaddr;
+	};
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
 	bool move_folios:1;
 	bool is_uring:1;
+	/* if set, use kaddr; otherwise use pg */
+	bool is_kaddr:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
-- 
2.52.0

