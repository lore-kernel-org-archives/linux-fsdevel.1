Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1982F7EED
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592141; cv=none; b=S/2lvG2RLPq3lm0tv/BgbI3VeLnp93qdQIxkEkxJkUf2BjbZ3CKAMGrXtEIl0vlGbkZiLFbO0UedqOUAa4ZZxOoiewNp//0N6gABRYjcNSrWQ2WC6Sx+l4lLiEWp99Hp6Whq2Or5ObGJDF3HWXIG8ijNAOMrNPuNJc4JChZe6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592141; c=relaxed/simple;
	bh=PVvFFRnJsjOT3ELo1D7sBFGBtjxPVxGxljGLBKQBPzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uDUg/qzyCJlbyke4jnJ38h/66ez7MG5q6Q6yszZHm+oRDvwBho2fWyNMN7TDXtYwjYCHHtEpLA2LOIxT1DYA5IK4YRZPW0kTxt2J7tWjpXaJMpqzAt9PzRwtdQbAf75nLsuQmMSL9HC7DOsjkH83Le0CHhURt3rY2i8ekf48/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0zpUQUP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0zpUQUP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so623271a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592139; x=1781196939; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTF+K/jjhjMbs+uqc9a1iigvfNerrw0i1C+LsdMcq7s=;
        b=W0zpUQUPb2s6AnAFrkkuDpexE5bEi1UjVMKKynqiTc4lkiJjo8+UHw1Wdau58XhRLx
         VrzFq4WxvjHcLkP1V81U6hbzHW1XCHovAOgBD2NMBeN9Yf943X4MaSrSuVRQMRw3IgI5
         LOzw5gmQPkIcojRFhTbloe71wUOYo6uMfDO7t1IK6RYoTtPrdoCLR3LwPmDNnhorzQ5d
         PwiiGpjWeUdOWQJIuRy2M3YQoPzHQvcQj/6j21HNuwab4HGa9IPdHNzjEkgaF4cyVxpX
         AeBqilQUdO4fYEevGoDUMfTDCeJT2t2meZa1PKBt+sH407/FOZgGFRKSo/O/GbxGzS4b
         /zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592139; x=1781196939;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTF+K/jjhjMbs+uqc9a1iigvfNerrw0i1C+LsdMcq7s=;
        b=pqyZ4XMz8/r8IbffKbgALxQZZ/RDNEjoRrz0WQa/3qy4Mgc6BsUhxMdSnLo/wYBYn3
         R4DxQZ4xhGOeJljylJfyO+4qQ9mQm7RQR4LK+Nsw9VW69iQW1YkXnVBoKoa5jRdUNAv/
         FieFJafTkDhMHZ+rMXyv62US8LBIUGbKr16mttbP3xIt6H+XzaC/4i+22KyasL/XnOJB
         EbHeGxiiS+WtgFwwsGHDGntrO+hK/2it/LFMqwrOHSBB74+O8qNW+axw6xe0/9NWlxvk
         HAeBc7Pa80SBbxqt0WGBW8MTAe8o0QDgwKL3zD7pt1QXYUtIvOsriB012OgchYZRc/TY
         xK5A==
X-Forwarded-Encrypted: i=1; AFNElJ+E1WdKl2zbVgx7+n8/HcT7TETUU7W0k2hkqbt6oXiew+muSFTrUlrOHBfd8nl0wk7Pr0LdnWmEm8k5EfdF@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPVBcvOX4fWARHkKEgrdzwOve5mEH4Pn/jUAFxB0r8DkeNuxo
	G/5FppynHZMxH7zIjlSfc1MvVCKH+uZTTDX8Or5dWLecoAc0NVMF3qMq
X-Gm-Gg: Acq92OFD7RGmAJTpz996UiLbCDA9d2E90Ol7H2Y+m4rG+nz2k+7lnhHQjkfEHJSFLbg
	PXIu8uF5D1SNqITys9dJsewWwDhDP+za4Pq5Y1r1AjVbapCcSA4W32hikTiN4thMSznUpftNf43
	Yk03MWbqA7qa/yleSLXfLlI7Fde/hmdQe2GHvlL9f8GLaN127+AB+0nmnoX7C3El+///nwMKk+G
	7IljC4/ZBUfNfmFz6zEFKBOeaadMfobCIzHeTHDKX7x/4EPda80QpGl17zGMPBrK/bnfYoiVmev
	16QwnopDlvCCzUqLQIF9yzjjG/KhZt9vDaPxY6N/xiB/Oxvq3ZmTZqqsKb/eygp9ZKAzZ9hifd3
	QmFdKdzXWIMul+XpZM+WvmHAbeDllD+882jQHtv8/05XJjPCZxEzu1O72e6IYn9iLFi82n/tg90
	arUSqB+Oo49n9iVq7xHm+W3olZJPlfVN095a+r8Yj1w/pQlnVzoYhCAt0ciTaW0bfPrzk6OgWw8
	aX6DJyuxNmxXWAHiNyJG2laKERowT7X8bvsOpNOdGJnQLA3TTGcRLqw9/vAg05jn0MpNFqk9TRk
	/Atr4r1TXQgTCj5eBJ1d/mSAv5EmlDU=
X-Received: by 2002:a05:6a20:b598:b0:398:9d5f:e093 with SMTP id adf61e73a8af0-3b4975945d6mr9519629637.19.1780592138973;
        Thu, 04 Jun 2026 09:55:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([103.129.135.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bd337sm5669880a12.29.2026.06.04.09.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2026 09:55:38 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: miklos@szeredi.hu
Cc: bschubert@ddn.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH] fuse: {io-uring} use request cleanup helper on commit setup failure
Date: Thu, 04 Jun 2026 22:40:34 +0545
Message-ID: <178059213410.15421.10567268398539539875@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

fuse_uring_commit_fetch() removes the request from the processing
list and clears req->ring_entry before moving the ring entry to the
commit state. If fuse_ring_ent_set_commit() fails, the request is
currently ended directly with fuse_request_end().

That bypasses fuse_uring_req_end(), leaving ent->fuse_req pointing at
the ended request. A later ring entry teardown can observe the stale
pointer and try to end the same request again.

Use fuse_uring_req_end() for this error path as well. The helper clears
ent->fuse_req under the queue lock before ending the request, matching
the other io_uring request cleanup paths.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org # v6.14
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 fs/fuse/dev_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e88..7523569ff 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -924,9 +924,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *c=
md, int issue_flags,
 		pr_info_ratelimited("qid=3D%d commit_id %llu state %d",
 				    queue->qid, commit_id, ent->state);
 		spin_unlock(&queue->lock);
-		req->out.h.error =3D err;
-		clear_bit(FR_SENT, &req->flags);
-		fuse_request_end(req);
+		fuse_uring_req_end(ent, req, err);
 		return err;
 	}
=20

