Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297407;
	b=CewyHUqiGt2olqc/AJgA+UYbsas8bYyHG7ZErpl04F3CYWVDYaTzjZHlRPwfX6n4FhGy
	 pU6oUSM7cgbYr5OLJys/Rm39ii+hN7hpJgWoLZznNbeOHy0Kvj8HDgPpV7HDM28NNDYBL
	 V8KiVNIrcQiynMqzBBuJpEaNHdnk1QzMjdVahoQzxW8edpPE4srThyM2gmNotOayJXw8J
	 RSHa2H+xoI70sdeLE8m1PKy1ETnrdUMGcgg15CnouTSzf5xXq2fMP4Q0Ho1IuitYTfSdJ
	 NgSlidyFoWXqnzYmQS7NngtbmCZcm1GBb0LM92ZBp6fKEewy4bBNqx7US1nfODNCUaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lY/j4BJTPHacq4th+geW3uU/xT9CmxLqWYLCqLTZczE=;
	b=AI7No2kM+ne3RMPmA7LCwKnuzF3Car6jhHaQfq/Q1xOjRPjVTaFSXV9Ez0ZrcDH9ExCY
	 6DwQ62UBUWULJUpVIiCEBcnlxIHjREYjlvDz0I2hnxY2kgH63n0B9V+DnEfM8hirj5Xy0
	 m5bGSAUJKdlhvHY3u+WP0kT7zoASnK1Fyq5UTrMLjRmKnOnDAbNTK7JVJ9uQ9UwjALCUo
	 crOWWP5DyXU/dlgEgGPlbHI4kVQBxLdta55BH/buYJHVGqfCJ0BljJgiVgsYIM4Oki/ie
	 827PznFb2TwVCnDGC51xbAU7S3ENIto0CPmPGxC0XbvutrBQxT9N6K3h6C83DbfqEhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=Ry1TF5jp;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BA60A6F4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4BA60A6F4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=Ry1TF5jp
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843a4ca671eso1211703a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297406; x=1793902206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lY/j4BJTPHacq4th+geW3uU/xT9CmxLqWYLCqLTZczE=;
        b=Ry1TF5jpHfEtNb/wLvErDSS8ox5RnKxXAurma5fBS90BM/ds83g3mFR2ATwEzR8DL7
         LVwlSKaZJySUADCRte4WXCkQq/GC1izQCx2MmN+Ca29mhrg/P1ThlGcHsKFoDCcGG6nR
         7x5vE5eVuyZJ3utrbUtEf6i12A5SBsj8j2eHN1Nlet+iT4vloY3EUrZ2st31Cw8vozMy
         Je+wyMqJp6Q0i3NADjc4eD9NiSRCeFvQKGH2wH3IhKOPEQSyE1+nb7RdhTwmVI1x4HWi
         mK7WpuT2eNnX+6Z9h4obk2oaLUvW//10MbXgsxrtBNqePP791KDaZsFj2KztFPd42ge9
         CigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297406; x=1793902206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lY/j4BJTPHacq4th+geW3uU/xT9CmxLqWYLCqLTZczE=;
        b=vOs1TlyzNfXr5jSP4TNoFV6RfkzSAbAWlFZ84u6//31D6EXi/CySSSlTE2T8I7+Et8
         gAx7NDQ9FrXMXENOyQPNFWKP16pIfZbv3tiUfJBCKPB43p9if6EUk4k8F5OOML//wOHt
         R1izP6QncrV43qJQLdpTqvsmvYXpz8v01bAKQxCODki/ACX67+c06Tc17RpLORUWwEWH
         G2kS0MYE0EqFY9WcbYnEhwf16Bq1E4RZ277+4QXxftCVcl6qiv70JEK5TBg+sDrkioVw
         kW1VJct+KwuIwVY+JM5YSMXytGiAVdzRkVBCpxYLESB6e+4Ck7RWt84OH+TsBNIL+Cog
         AMjA==
X-Forwarded-Encrypted: i=1; AKwUvBzGOCfAPzMKRhbzl4U232DCT54y2JNqz0rOyDLqUjW9ZxRaCyREp2a0+6wyKWWEp7G43GuYCSCQElYTf4ke@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+uL/+Db7ycv9p7alsyKmO7lf1ofawgXAMCdEKwZZOZpmrd7Av
	9OoLMefYNr90ipCeMwU/01U0tuumiUO+RdxDJUwrsrUTBv70hRrA412nh28t58mvmTU=
X-Gm-Gg: AYBFou17J/VsbLFeqtFJSlbAyEEaFaW5VDdJwlUeC9iKGwJraoSkxfQJUW9qZHb8Uew
	SkCJ1FPvl0r3Gl3cCzc9sBrodUymCI9WPMi5me8ezdogtGfD13LpR7E9/h7GfCAFnRCTcbENHJ4
	mOPRUxJRvI16Ob2CX4MSmWylVY85q8LcPp0q9fPb/4DEuv2hD1Vg9w6t18IJnHj9yiOweA+UtML
	UIq5d1v7xIeso4vYQf8Mqj4GgDJc/+9PDN6lDmnm3B96xW7FeupX4vvvIysebrPXBfQ1+lz92de
	QGCq0Dp/ySIWaMF7hih6we6yAF4ADLDK37tt6F1JlcM9k7/++DZgEwpIllJyOOtOZgbeeuxgYBF
	Zy8tDXOwvhzxqIfVSB/1d7ir8qMR2pp+8MUbFqb6T0+oyawQXos26g86RIauv6hxMDZFSQ3VZ0r
	ImsX8rbjmkVNQuaOTNtWD/Ssxvj1qPpVVLnoS1cr4NDNNV6Pls0O6kQoZkL+PZf58ptrNog5Szf
	L6Wu427evJL3cwr/Du3M1GvOj7VlUtUamZoVCWF4INe4fhPWYkezq6kPMF4FZNm1iRMNmu/2QJ/
	mn2H18tBemgNdtjftLzm+0R/peAZyAiaL+vBQsRi/9ihop3QiGycuYjCRBTqyCySila7LLvI
X-Received: by 2002:a05:6830:34a1:b0:804:ec69:3979 with SMTP id 46e09a7af769-85ac090193bmr5308756a34.21.1793297405639;
        Thu, 29 Oct 2026 11:10:05 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3501abc9sm213289a34.0.2026.10.29.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:05 -0700 (PDT)
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
Subject: [PATCH RFC 04/12] nfs: concurrent O_CREAT in one NFSv4 directory
Date: Thu, 29 Oct 2026 12:09:49 -0600
Message-ID: <20261029180957.387138-5-jonathan.flynn@hammerspace.com>
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

Set IOPF_ATOMIC_OPEN_CREATE_SHARED in nfs4_dir_inode_operations, so
that the VFS takes the parent shared rather than exclusive for an
O_CREAT open in an NFSv4 directory.  Creates of different names in one
directory then stop serializing on the parent inode, except on a server
that reports itself case-insensitive or not case-preserving, where
"nfs: tell the VFS when two names can be one entry on the server" has
set SB_I_NAMES_COLLIDE and creates keep the exclusive lock.

This is the only user of "vfs: allow the parent lock to be shared for
O_CREAT", and what it needs from it is the guarantee that the dentry
reaching the atomic-open method for a create is in-lookup.  NFSv4 keeps
the dentry the VFS gives it when O_CREAT is set, and publishes the new
inode on that dentry; because it is in-lookup, the dentry is not in the
main hash, so dropping it is a no-op and publishing it is permitted.
The name enters the hash exactly once, and until it does, a concurrent
lookup or create of the same name finds the in-lookup dentry and waits.

NFS does not use the exclusive parent lock to serialize its own
per-directory state, which is what that patch asks an opting-in
filesystem to promise.  Both pieces of state a create touches are
already under finer locks: the directory's change attribute and the
cache-validity bookkeeping that moves with it are updated under the
directory's own spinlock, and a dentry's directory verifier is stored
under that dentry's lock.  Neither needs the parent lock held
exclusive, or held at all.  The verifier is also ordered so that losing
a race can only cost work: a verifier offered against a directory state
it no longer reflects is declined rather than stored, so the failure
direction is an extra revalidation, never a dentry claiming stale
validity.

Lookup and readdir already run with the parent held shared, and
readdir already instantiates dentries there under that lock:
nfs_prime_dcache() takes an in-lookup dentry with d_alloc_trylock(),
skipping a name another thread holds in-lookup, and invalidates and
retries a hashed dentry that no longer matches the listing.  A create
joins concurrency NFS already handles.

NeilBrown's "nfs: remove d_drop()/d_alloc_parallel() from
nfs_atomic_open()" states that the method has exclusive access to the
dentry in one of two ways: O_CREAT, where the parent is held exclusive,
or a dentry carrying DCACHE_PAR_LOOKUP.  Setting the flag removes the
first of those for open(2), which reaches the method through
lookup_open(); nfsd reaches it through dentry_create(), which still
holds the parent exclusive.  "vfs: allow the parent lock to be shared
for O_CREAT" supplies the second in its place: with the parent held
shared for a create, a hashed negative dentry is rejected and the
lookup retried, so an in-lookup dentry is what reaches the method.
NFS's invalidation of a cached negative for LOOKUP_OPEN and that
rejection do not overlap: nfs_neg_need_reval() returns 0 for
LOOKUP_CREATE before it can reach the LOOKUP_OPEN case that invalidates
a cached negative, so the invalidation that covers a plain open never
fires for a create, and the rejection in "vfs: allow the parent lock to
be shared for O_CREAT" never fires for anything else.  The opener newly
in company with a shared create is one opening the same name without
O_CREAT, and that is the opener the invalidation covers.

The flag goes on the NFSv4 directory operations only.  NFSv2 and NFSv3
reach a different atomic-open path, which has not been analysed or
exercised under a shared parent lock, so it does not get the flag;
adding it later is one line.  Referral and automount directories are
unaffected, since they are given different operations vectors.

Every other directory-modifying operation still takes the parent
exclusive; for unlink that changes when "nfs: remove files with the
parent directory locked shared on NFSv4", later in this series, gives
NFSv4 ->unlink_shared().

The measured effect, from a 7.1.13-based kernel carrying an earlier
revision of both patches, is in "vfs: allow the parent lock to be
shared for O_CREAT".

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fac8450b65..808bb8f1c1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10869,6 +10869,7 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
 	.fileattr_get	= nfs_fileattr_get,
+	.iop_flags	= IOPF_ATOMIC_OPEN_CREATE_SHARED,
 };
 
 static const struct inode_operations nfs4_file_inode_operations = {
-- 
2.43.0

