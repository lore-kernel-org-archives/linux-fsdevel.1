Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297429;
	b=aMcfeIk+NKS/2L85kkDjcNAcFxFFo1Ze9sOYYUtqvJ/cLHh3gX5EfmpsuPzBkI3P+uha
	 A4Z7TqwTsIWJGY2butKba/Q01wSKNhKOIsjePUq7r0TRFCSe4pm5JPFamphwi7BUw9JUx
	 nUvflTB95amWlgYncJIHUMiQnzHuDAzQnPkLKnyePEY4R5YQpBYyaGA3qluDU4+Rho7yd
	 dDXRt3+alohhQg0O6+JECnKJrkAnaFByhjhgnCmScshWdXwRURSb5BC4moh3s194EUDBN
	 BFb1Z0jKOi8yz9JwMgOG6WEfmbT0t9e/gtYJZIkx4bZux6mrSAuRP/IvPuYBOCsmr6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h/Q9DLGqoDPx/XvjFFuDFe37sX7w21EVwh1yv9Pf91Y=;
	b=kWokqu3HCGOvQjrDlatp9TVEiRp0I2/Y1MmYW6d3ioqQfgfLHC8LAyLE10mHyP4aJRmg
	 YhWHKRDn6Fg+vOTErHrDE7MXjpCRlJwmHJ4q4NC6+H0gDf/kFYWge2DeDk5FIjKGGm6Yf
	 KedVTlaY/XtI+ZZvFPbgrBnAwrsTYmQvoBV0sbsGorp2r7CelcWZQoWYG6z/b4udw5J6o
	 bBDWAKcor4qdOTZ6yXS5FEHYEnTIhz2i5VRC/eUoyD9TAVZSFVcw8xXVwlBuEdqTtADvR
	 G5Sg04O1bpG5tWce9y9eHlopE/WIORg7Eyb4oJ3suQQ3Id4isaj52aVmWQhJyHfGLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=K9KYxWzC;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF660A383A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BF660A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=K9KYxWzC
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84a248254f4so1505272a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297428; x=1793902228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/Q9DLGqoDPx/XvjFFuDFe37sX7w21EVwh1yv9Pf91Y=;
        b=K9KYxWzCPyBeEIuu0xpic15O7tkqjAgj1nlmkbsQeMWvTEey5aLgbok8m4unZflqLY
         rs5fGM87nV69qB8wilEMbeXeAE88KP9x+lNfrUrKwQArfvUXNC2uV/OQZrUUapzQoqms
         vl6mrG6fe9r5iM3347P0w9f4+fd3IuhyxmhGFebTjl8VZR43FAFyIgmRZSZ33LjLmsS4
         OP3WuXl2s/15UqqSNeOKc0PXcccomgQi8PL12E1a2styv3LRLiireJIzjhCmd38KLQC1
         0y1fJALNITtpO1nxWvBnGQDumgMFnQjGS7ppjXFe2g4UxkNjTRViIV9I8CyqKY0Y5IdR
         ZV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297428; x=1793902228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/Q9DLGqoDPx/XvjFFuDFe37sX7w21EVwh1yv9Pf91Y=;
        b=IHixJVZplNFBuE70Fv+sTxAACWny73KuJEarkAfJs9M1E1KBBSgb4bUYpUnSuqN42S
         geMeOiuzjwsM+IyJd8v8jWHcqfTr3H1rb2dWhfnLs88KtCQnoXnL5RJ96PXHVIyYca+W
         /EX+Xg5AgRkkWaejLdciI1cpthwJdM+ONEZv1BhuFXbn76jzNcPNfQX9DHEx5X6gnnyN
         v4N0eapIR0VHnqtL0Kk2XDPGWkbPB+RO+keLMGDB+RmldpG+xI5m9rB3SP04F6Z+k9pv
         B3L9hD/D1rkB7QPHS5CWbhFL3W2NerzyyJ3ffbMv9rXHo81jLs5+xduX+Vy8Qr7U636b
         tjtw==
X-Forwarded-Encrypted: i=1; AKwUvBxF/wEPBrA7j3Iz98L0reQZ/rbAlYOdEY/sn5BIMatwRct8YGXKAnmOP4wtGvsAxGHoM5XRUAUMYcdBy14M@vger.kernel.org
X-Gm-Message-State: AFq9FYKefUNUOuO+z2BHtu3ym4KclHbxI2I6oqZGttWH3PEmkGEpgocY
	XrOW9/0OhSsIEDi9GbKJDtlTWqRpvlkQXFiaiFE9Z5eWEwdh2brxpipMsnz6rnbg5dM=
X-Gm-Gg: AYBFou0MTJUh7bb0xGeUTSKgcrKZmaBe/gmDeXcxL/9NfbPVF+1vOkyloRKT78yWKKK
	UKzjUZhCRRmS/b0X6OGqRicNVuQISWWB/mfQ8n5Si7i+NU7Y22RlRjcZxk7CjYpnJmIDFt9u7wi
	/O71ITwWbp8Thxh0bhSOlwygIORt/RFrKz3gKA7VHx8t+v2w2YXzDmpgrmHb9gBhJDujjn3ovwO
	fo5niLBS3EyPw32BhHf9RZ4OEEWPxszlKg13M3fFxX8GMlVwFXiKD/buJ7QIBnPTlAh7D2NBT0y
	L4JVEd3rzRK3XUHJpOSqwvudSJD8BZ0PqHMvh4RQHv1ygzMiyCwIvzQJSY7z3wQf88cJ9DOZO8W
	jyfpr8v3Mk+DKey2y1xCiLj11WlS4/bbKor/md3/2aLOFRy8Q908oY55PBVs4uQYVdgSNA3B/jr
	fwc782dtof+FeJbS+WrYVgVMz96Mc4wxHT8nXJuVDn+sLbfubJuFhvE04a+Xn0vEW6t//eRzWeA
	ycMlOP19VyizRcl1hjQuTEZVo8offrJM0NQVQ6jovf2MekSCuDlxao/enWF3aIO5G6uWE/hKEMW
	gwp9IzWLRGdEgvkFT9yQEqVEseeMmbDZFntCEbNTMb7dkAgV62RHxrb74hgyFcwuxl+dfHUHWg=
	=
X-Received: by 2002:a05:6808:181f:b0:54c:7bef:90d6 with SMTP id 5614622812f47-5640dbd679bmr1506b6e.4.1793297427868;
        Thu, 29 Oct 2026 11:10:27 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c5437cfcsm4755474b6e.4.2026.10.29.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:26 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 12/12] nfs: remove files with the parent directory locked shared on NFSv4
Date: Thu, 29 Oct 2026 12:09:57 -0600
Message-ID: <20261029180957.387138-13-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
References: <20261028041023.3738553-1-neilb@ownmail.net>
 <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let removals of different files in one NFSv4 directory proceed at the
same time, instead of queuing one behind another on the directory's
lock.  The server orders removals of different names.  The client
orders a removal against lookups and opens of the same name through its
cached entry for that name, and against listings through that entry and
a count of such removals kept per directory, as set out in the changes
before this one.  A removal it cannot order that way is done with the
directory locked exclusive, as before.  On a server that reports itself
case-insensitive or not case-preserving, every removal is done that way
from the start.  A server that treats names differing in other ways as
one, as Unicode normalization does, is not detected, and there a
removal is not ordered against a lookup or open of another spelling.

This covers every NFSv4 minor version, NFSv4.0 included: nothing here
depends on sessions.  NFSv2 and NFSv3 are unchanged.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fbf9e97815..0acc03dfe6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10860,6 +10860,8 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.atomic_open	= nfs_atomic_open,
 	.link		= nfs_link,
 	.unlink		= nfs_unlink,
+	.unlink_shared	= nfs_unlink_shared,
+	.unlink_shared_done = nfs_unlink_shared_done,
 	.symlink	= nfs_symlink,
 	.mkdir		= nfs_mkdir,
 	.rmdir		= nfs_rmdir,
-- 
2.43.0

