Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81333B6D9;
	Wed, 20 May 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257784; cv=none; b=aFNFf+Jk2RiTiz9+xfRRPRWXgAg+ZuVP7AqeHOHw9NGyH4as9UAWP2D9dhAH41BY81+5XcN+tP3nf3sZS+e1egnI0EOQMETZ4ewormbu84efPDR/ciFombsqcZQWt8cKzPXIr9+uNqzyUN35ZpIv6q9AnWdqj2mQyDGc1kF8+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257784; c=relaxed/simple;
	bh=S3s830/bFEdrrKaBJREyVS7Ugxv5GFu4+/X/Eqs9y6E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRW3HElFQ1CTgO9iVObKitnX/MYW3wC2I/mhGnW1PEDzCsfIoeGbk4bHw0NKyIPhyFRJ6u0iIg75uNA69SjUsPM62/DBCvnFRJW/1jhZY2n1ZagxyDxhRdxyFIQ+uFEAcN/QICUJt5CJmK63fBPOZjHlYrixnlq9/YYriD7ZGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvac53q+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvac53q+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DE3711F000E9;
	Wed, 20 May 2026 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779257783;
	bh=OBF/v4IUUGxALDVWMZZ8wm8Jg3MJgGDvgAM4aTOKaDE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Vvac53q+VyM7Rl+fvime3w9UFDAs+ctyvxMOev6K9QNqr6RPVOIDm+vewfsQOI2a5
	 URAbVjObpCXvghefNlnuxGbojEKd3tmqa/iHcKirK6nlT2aVewfvdvuoASm/FLb8lQ
	 +Wi9/wD9ewfIe1PUvacNcWLI/57LOmaqD24AK8F6fg3R9hQTXxU/eq/niJfd59ClmQ
	 DXFtM84+F3cEk/Ge3KS6UnxUPknZrsWa2PC4b9altJJv/rI94SJyhjWmb0fRbtf7Rg
	 0hfLTsjaOBBwzeCd/J27dr7h0u/hPJKdVqdr57V6crygkcWbVVuV7OpJcbZlr32Okh
	 ysZiIljYjf8cQ==
Date: Tue, 19 May 2026 23:16:22 -0700
Subject: [PATCH 4/4] fuse_trace: implement striping for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, hch@infradead.org, joannelkoong@gmail.com,
 john@groves.net
Message-ID: <177925767769.2711065.4883228302884935133.stgit@frogsfrogsfrogs>
In-Reply-To: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
References: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    7 ++++++-
 fs/fuse/fuse_iomap.c |    8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index caaa19ac4687bf..7bbcc41cb22197 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -457,7 +457,9 @@ struct fuse_iext_root;
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
-	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
+	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }, \
+	{ FUSE_IOMAP_TYPE_MAPPED_STRIPE,	"mstripe" }, \
+	{ FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE,	"ustripe" }
 
 #define FUSE_IOMAP_IOEND_STRINGS \
 	{ FUSE_IOMAP_IOEND_SHARED,		"shared" }, \
@@ -626,6 +628,9 @@ DEFINE_EVENT(fuse_iomap_mapping_class, name,	\
 	TP_ARGS(inode, map))
 DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_read_map);
 DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_write_map);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_read_stripe_map);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_write_stripe_map);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_cache_stripe_map);
 
 TRACE_EVENT(fuse_iomap_end,
 	TP_PROTO(const struct inode *inode,
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 14e411afefaed0..074b5d49be3eca 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -847,6 +847,8 @@ static int fuse_iomap_from_cache(struct inode *inode, loff_t pos,
 		err = fuse_iomap_adjust_stripe(inode, pos, &lmap->map, &fb);
 		if (err)
 			goto out_backing;
+
+		trace_fuse_iomap_cache_stripe_map(inode, &lmap->map);
 	}
 
 	err = fuse_iomap_validate_bdev_access(fb, dir);
@@ -1112,6 +1114,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 						       &write_dev);
 			if (err)
 				goto out_write_dev;
+
+			trace_fuse_iomap_write_stripe_map(inode, &outarg.write);
 		}
 
 		if (fuse_iomap_is_striped(&outarg.read)) {
@@ -1119,6 +1123,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 						       &read_dev);
 			if (err)
 				goto out_write_dev;
+
+			trace_fuse_iomap_read_stripe_map(inode, &outarg.read);
 		}
 
 		err = fuse_iomap_validate_bdev_access(read_dev, READ_MAPPING);
@@ -1141,6 +1147,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 						       &read_dev);
 			if (err)
 				goto out_read_dev;
+
+			trace_fuse_iomap_read_stripe_map(inode, &outarg.read);
 		}
 
 		err = fuse_iomap_validate_bdev_access(read_dev,

