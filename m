Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297406;
	b=lBmLF1nhQJN51adLoO//DaHmqtyFzRdjY0mwbaJrF5s4sxPLjRTMB8bDXwU/KC1yni8j
	 3HDWkz86ZFjFcE7Zaic/HWMV2GzXfDFop78PqXjxZa3XFkwXxK/lcSPVhnOykyrl0UYKh
	 AwXQ0h3jhQI6gFxMp1j//PgpOqRaUVa+rDHRMllDPB09N4hd5ORt8JBtz4Zn+Hdvq8tnL
	 dNhP4XR57Vlj/4R64vxQ3S9IdOxk7efKO9/KBk9KiEZHQuWwMVoZYW5RJ6fEX6MhtPABB
	 iqTksigbHAYkufPmbHTpZHPVZ+zasL5hrWBeDFxGHCuAYZmzpKtwNK0d7XN5xQo1COg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pm1R1Yg8qM+RQX7ApNjTy6aurLKiAREVlSqc/qkmz+A=;
	b=WX05p6+wvgNF0uGP+NkTwWpO/yNOsqWFaLv4JInNc3yyxYWf8/k4W4kUHJ9x7YMvx1na
	 zQP95mwTOCi0Z6TmzxyH2l+svvDC9EJWzIr19zhEQK7qX5QgAW08F/ipJaE1v2to1jeIj
	 /TNiToGDeK7E1GjMVtVZpQFc4tpRvG5h4MTWMUD7YqCtHseZDe0W24RDjuD//WPkpgDRW
	 v1maiAY/7mUs2/ayBnP1V9J3fJ2/dKaBjArADasVg0qv81kphup+2ZjolKA2QbmZ9dWFE
	 sC80q+HstxnPufEx8Nd3IlSGHJXS58Iz6oAlKzsZmcG966E5cgYWExmKoIudoi+Xoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=m41LuiIJ;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331660A261C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6331660A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=m41LuiIJ
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-823e4047037so1733002a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297404; x=1793902204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pm1R1Yg8qM+RQX7ApNjTy6aurLKiAREVlSqc/qkmz+A=;
        b=m41LuiIJlm3MggjpHDY1vfjUIc3UfxLDNZGSIVM8Fm3PovKNWnn9hGmi3Gz42FmWKW
         1089sX1WmPElVGNk7+XJXmOA7D40jb8N2b9CJ7tpRrb3Bh8LnlsDoLp0mjQk8fMUvPPc
         mdP4X4O1OSG/tPVrUxR8lw4cIQI6sgkwPLL/pVmC/I1mHKDXr0Uj4hCOnO4+6vWQxXMb
         l3c4nMqwgJmYSolJYQGozefAPJxYZjEaz5i60mFN+Tg5i70xdP+V//Ff+4djT3yvRDy5
         mm6T7swk7bJkv2f9lyBPEDqW6lD6W4FmujHpQTImEvHSWMdvKuOsUvoktLBUJl8VThXJ
         HuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297404; x=1793902204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pm1R1Yg8qM+RQX7ApNjTy6aurLKiAREVlSqc/qkmz+A=;
        b=cVX9LFkxI/5ropp2tpj70AWV9EOD1Yh+q7h6PdRPR41/iNlr8QiM5OKMAMCxSjSJAo
         g3xXA2ra35s4PtEu2kXlZ+/Hmbfxhvq9aTuaMW/UfwRyhJhL7/pxcXx//pY/4mX4nTbd
         1E4Wqu9EFltQL0cjLkAMtza3e2VaXzJbpdgog/27XbM46tzr9bt41rddrVcuCMJn+HDd
         sbHYlXKhJl5ipvfP6sjK423UKo5HhjaoU9YNY8qd3Y55jax50JWhn3EqJwY3M4Df2MBW
         XeibGC3mTSxW0Mb1k8WXFUFhm3Okl2eHZ3oIarUPta9G9FEz/7LVc6BO6eAKkaIPsFZN
         ZqEw==
X-Forwarded-Encrypted: i=1; AKwUvBxEzJvuCjvJDD4pJia1+zXzBygpFIfZQAdAU62/B2Q0O5sjZwADSgNdliSupbiGJ/RKm83AVkw0t7B5fNpF@vger.kernel.org
X-Gm-Message-State: AFq9FYJdDXz3MBpc3Fl9PyzstKSPojQCBJxnqUtyIWx7lfoOSLgOUtdc
	1o1UpYwOFwwG6dDCh5PH6g7knE2hn5S+1e9Dfsi7kdfE/3VWtDYanGIzm2Z+pmJC+xM=
X-Gm-Gg: AYBFou1W9oGePw6Ww3f2CxJXUPccww9PbLAhjh1+xQq4vac6LGiH/s5PNExN+QI2XWI
	m5HYqrG7pWOKivQDrkKrzOH6IXgaEyp/fY8G1TmO8kGiJ+m+jpuR7iLWcQUH5I2N6cvQvG44wRe
	fIsPKLcOvf64U5MQXzs+a1v3J2ZUSTQaGTP+1Zj+I8Ty0SGVH1+mFSVSkcB4IiicQAwakgSokGJ
	m8dqrGEPJbiTWEKHmUrt/HlQA713LhYLIRg2Y+0IX/vzyjvW/8jDDZjBw0o+75qx1Hlx9j2yE9m
	EBCqecNKEqhYaiGX+nf+wApWX7Q7Sd7SKtQFlQFH4lJoHM6Bh2QHwlpO6dO2VvR4SuCOlD5Thg/
	IP0zCrbueSXDJDxibzrqvcTevCHk8fR9IUXXnv0kXCNh6tpUAwReGfwypMbbQoRjqk42TGs9D7p
	28bORu9MiCQ6dlP/q67Zi3wCmE5bSkC/dXCZFb2LlyjEHHJJUfU6M+DaTm7Aif/NHFl7+IIyBoH
	Ji+H8KOWQ2mEUCBoXbcWJ5PSuFAX0Qat8fnek/XFMF39rhSHFJvFmIootXUP12a36oyNn48ueDs
	uHcK5LdcpD3zFaPbM9Uwv0/+i2GS4++jmob/hFBRup8zt265hq/sk1o5hOX+UZ7Qwat7EIgr
X-Received: by 2002:a05:6808:238a:b0:4f2:ac42:656b with SMTP id 5614622812f47-5640dbd6766mr13996b6e.7.1793297404102;
        Thu, 29 Oct 2026 11:10:04 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c5a4d8b7sm4093603b6e.8.2026.10.29.11.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:03 -0700 (PDT)
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
Subject: [PATCH RFC 03/12] nfs: tell the VFS when two names can be one entry on the server
Date: Thu, 29 Oct 2026 12:09:48 -0600
Message-ID: <20261029180957.387138-4-jonathan.flynn@hammerspace.com>
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

A server that reports itself case-insensitive, or as not preserving
case, can make one entry of two names that the client caches apart,
because the client compares names byte for byte.  Mark the filesystem
on such a server with SB_I_NAMES_COLLIDE, from "vfs: allow the parent
lock to be shared for O_CREAT", so that the VFS keeps the exclusive
directory lock for creates there: the per-name exclusion that replaces
the lock for a create made with it held shared covers one byte string,
not the names the server treats as equal.  The client learns this when
it reads the server's capabilities, which it does again on remount, on
migration and when a later mount reuses the filesystem, and it updates
the mark each time.

This is a conservative fallback.  A server that declares itself
case-insensitive should itself treat the two names as one, but one that
did not was seen making two files of one name when such creates arrived
together.  No filesystem relies on the mark yet, so nothing changes.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/client.c   |  1 +
 fs/nfs/internal.h | 35 +++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c |  1 +
 fs/nfs/super.c    |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index ea99b3c105..30206b309c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -975,6 +975,7 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 			server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
 					  NFS_CAP_CASE_NONPRESERVING);
 		}
+		nfs_server_publish_name_caps(server);
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5af6a032f1..34b8aff4e0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -224,6 +224,41 @@ int nfs_init_server_rpcclient(struct nfs_server *, const struct rpc_timeout *t,
 struct nfs_server *nfs_alloc_server(void);
 void nfs_server_copy_userdata(struct nfs_server *, struct nfs_server *);
 
+/*
+ * Tell the VFS whether this server can make one directory entry of two names
+ * that differ as byte strings.  NFS installs no ->d_hash or ->d_compare, so
+ * the dcache compares names byte for byte, while a server that is
+ * case-insensitive, or does not preserve case, makes "foo" and "FOO" one
+ * entry.  On such a server SB_I_NAMES_COLLIDE keeps the parent of an O_CREAT
+ * open locked exclusive; see atomic_open_create_shared() in fs/namei.c.
+ *
+ * server->caps is derived again on every probe of the server: at mount, at
+ * remount, on migration, and when a later mount reuses this superblock
+ * (nfs4_proc_get_root()).  So this is called wherever the case bits of
+ * server->caps are written, once they have their final value, and when the
+ * superblock is set up, because the first probe runs before it exists.  The
+ * value is what the probed file handle reported, normally the mount root's;
+ * the homogeneous attribute is not fetched, so a server whose answer differs
+ * below the root is described by the root.  Migration runs the probe from
+ * the state manager without ->s_umount, so the update is atomic, and it is
+ * made only when the value changes.  Two probes of one server at once can
+ * leave the bit as the earlier of them derived it; that needs the server's
+ * answer to change between them, and server->caps has the same race.
+ */
+static inline void nfs_server_publish_name_caps(struct nfs_server *server)
+{
+	struct super_block *sb = server->super;
+	unsigned long bits = 0;
+
+	if (!sb)
+		return;
+	if (READ_ONCE(server->caps) & (NFS_CAP_CASE_INSENSITIVE |
+				       NFS_CAP_CASE_NONPRESERVING))
+		bits = SB_I_NAMES_COLLIDE;
+	if ((READ_ONCE(sb->s_iflags) & SB_I_NAMES_COLLIDE) != bits)
+		set_mask_bits(&sb->s_iflags, SB_I_NAMES_COLLIDE, bits);
+}
+
 extern void nfs_put_client(struct nfs_client *);
 extern void nfs_free_client(struct nfs_client *);
 void nfs_cb_idr_remove(struct nfs_client *clp);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 113c199a6f..fac8450b65 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4020,6 +4020,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (nfs4_server_delegtime_capable(&res))
 			caps |= NFS_CAP_DELEGTIME;
 		WRITE_ONCE(server->caps, caps);
+		nfs_server_publish_name_caps(server);
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 23292680ad..e70cef88fb 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1082,6 +1082,8 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 			sb->s_export_op = &nfs_export_ops;
 		break;
 	}
+	/* The first probe of the caps ran before this superblock existed */
+	nfs_server_publish_name_caps(server);
 
 	sb->s_magic = NFS_SUPER_MAGIC;
 
-- 
2.43.0

