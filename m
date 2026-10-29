Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297401;
	b=wktBb3uE/8WbarFPBlKRmH6ZiHmZPvgRkN2cflDxZ6LkwMOnFRml4x9KqFX8EY0VVnJV
	 YWnLqb2f5/73PEmHW4+JQxV2Jf4W2/Q/mfhuCQ1klDsORPMuWrcqoV3lhPucTOM4KC53e
	 QbYDF6IK5aP7RPP9HO77mkJcGaN7MpDojw/BlOUUWNchLCXeZ3iRwrncmXJbkCPg/xeok
	 mzsmuAqzJJ9wbA5kDMS39KrQ3KnlW+RqoSvsGGBeqdzIXxs1zOM/E7czN1y00+F8T7qwR
	 y5LkEdVoURVYx7UJpGV6SeiJeUfnRnNr7M9P1bi9tfxOJydpm6q9gsR/v5vZ2WwVAPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VIRuN5RJjbuv5CSzCNORIV49ClgI3heQ4aV2Bv/ASqI=;
	b=GRlsywSUes0K04lRA9oUqxEqrqsY3MRiXKJ8UlLUFPguPFm7AieQGOtBRdCWVp73IWdF
	 ZLmijLVq95NPdoPeMTY6MLDFwP8Tycr4WcW+tG6rYmAQW4iRWEVMRtWqWHDU1SmJc0iBi
	 Dl6T5xUTTLbBH9MjhdnMe7Uousk7Wxa5ZimxxdFfT5ZD1brqy0Woq7Xl2kshBepRXwNBd
	 l4Tvbf4yRGffo5LzrcmYIQwau2DfOrALrvSiTNtrOxm5PajtV3zw6CjcWOvBr5C1YR84a
	 0xys5juRvyQBkvYvaid4eOwKO7M56RpMd988x4fZHWyVXqJIicRYqNjiVBjrjOOa01A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=WZLxBgd3;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB260A3804
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AADB260A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=WZLxBgd3
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85a6c747dc9so743825a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297400; x=1793902200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIRuN5RJjbuv5CSzCNORIV49ClgI3heQ4aV2Bv/ASqI=;
        b=WZLxBgd3shKUN9MMxfxeWoZmoSQYqQnLq8nPl6E3Zj9r4MlVGXVCy7M50RgeVTldnT
         QzFj53iiOXruAIVXf1MEj5jDvkLWMdRs3iT0mxxToRMGZ+ayO6ETyGc+nq7PoDNt2Gx9
         YkQkzqm5bSa1e9r7FmarbxkfhbsqrEcIBpWIsHl6SKMsMGlN9zJXSX4ZUIuCdoa5xLj5
         kHaXFxjOYlyyundHMLrv/EY/3B9cJY8Vf0e7+lpfd/dwd4T2l/KhC4HPAoXdrgVCuqBj
         khWsYoU1VSkvWeCLGxvsw8NRcQMwmctajSHnaCdrAon9Ig5dwW+vqWMvyM6NsjeB39Qh
         xHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297400; x=1793902200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VIRuN5RJjbuv5CSzCNORIV49ClgI3heQ4aV2Bv/ASqI=;
        b=NZW7jeaegy/cTlN/Ao8/MdMWd4zko5UYQ12l32tDuXvtRuOyV0Y0Q/+UKP22bXb7KJ
         /1igdEKQl1uv6YwjCUrWW7SjTpY1E1OD2YSxc7nkXCbc12XSD7sKAHKArDTkiECbM0pe
         Js5WpwhTIf2k5JELYL9rGNpX6f4m4gzoUbb86ZdKLVx67/9XbVDOh/xiduxBQ8bU/zDR
         IqPGFMqlbSdOqZH8voeMJiliPTgdUEKj3O3AfxSGc1Wk5fl4oz7UPhF+VEOyjzwZRk42
         9G7x3YsOQ6uSSSpkIP9CSm4N7S/JHkEQLHVkVs04pNHLKCFgqddxgfJcqR0xoNsRIOD5
         Fppg==
X-Forwarded-Encrypted: i=1; AKwUvBzxWVi2bdQJcE3l3/0akActXWfYl0Ql0JjpVwcloM1f/ux6DlyTrwxndWz/5cNeDIrZPcH7Tl5b72w0KVr2@vger.kernel.org
X-Gm-Message-State: AFq9FYIU2M1g3+TsKnkUEiNgSPdOAw3QikzwZivJhzvCZ9sFv5IF0w1D
	+2O+OtJGugbJO0ABBeE9tYoR2/g3Fh2waKo6Bc4anzfuOSejzBh6m0Bc47b4O3Pei0U=
X-Gm-Gg: AYBFou1l/URyi6FuuqdcUkL0maxzXy9u0cIgpVkGsxaJU1VI40ppA1c30t0b+crtA7i
	ds2qns9yoUnLRMndF0rJdLpDTPFKrGs4k67arnPGjVtPpll97YS/ITDD8MVbUsSXma2Pm4yT9Di
	gIriYDVktS3LfTZQn0jPEuMXi8HA/nOXM7aSazbIawXEZS1kRcAYEiUYT/FJfnfCxF/5HPpzk4j
	bRNC+li8hIO4SKaVovR2E4Z94f5AB6k5wjb+QpZaUmUxgI/U8K0DsFD05vjy3fIK9oREk5Bchg+
	VJbXMFiNC5UNeXCDJ+1PE2m6iwZhVe9MYrvZuEQDHc/nozVwJ0CHZVa18OKFMNhawVVhVvA81Un
	8+YhJHzac1ggQMWsBQejn0r1KYV76xG2u8KOvMWTQgGHlQQZzebtlKtPgA3n26gFcNwKjjfWdVA
	wT6hDd10lK1CrtW8xJfxPL/dQPWUfBdsa4rRZYgfVTDHdzKaVqg6pJLdB7Idd2I6EAI1mETXsbD
	OiHpi59RVGlMX7MCClcyOBNy3dADvDVgwdl/P1M3h1/9w88wDnjMILW4zcLQIb+l71Cd6AWkV+k
	0gF22XntNIETAHZqP+44MWQ0Bkmh5A+J5ntuuNy6eLMpgYMUSfwadNoibKEz5bZHnOpNdzNz
X-Received: by 2002:a05:6820:4ccc:b0:6dd:c600:ec2e with SMTP id 006d021491bc7-714ddecf85amr1873577eaf.19.1793297399528;
        Thu, 29 Oct 2026 11:09:59 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d12f2sm160242a34.17.2026.10.29.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:09:59 -0700 (PDT)
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
Subject: [PATCH RFC 01/12] nfs: update a server's capabilities in one step
Date: Thu, 29 Oct 2026 12:09:46 -0600
Message-ID: <20261029180957.387138-2-jonathan.flynn@hammerspace.com>
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

When the client reads a server's capabilities again, on remount, on
migration, or when a later mount reuses a filesystem that is already
mounted, it clears a group of them and then sets again, one at a time,
each one the server still offers.  Anything that tests one of them on
another CPU in between sees it missing: a case-insensitive server looks
case-sensitive, a server that supports security labels looks as if it
does not.

Build the new set first and store it once, as the NFSv3 path already
does.

This was found by an AI coding assistant (Claude Code) reviewing how
the client derives these capabilities, and has not been reproduced.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 22a2a4009d..113c199a6f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3896,6 +3896,7 @@ static bool nfs4_server_delegtime_capable(struct nfs4_server_caps_res *res)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
+	unsigned int caps;
 	u32 minorversion = server->nfs_client->cl_minorversion;
 	u32 bitmask[3] = {
 		[0] = FATTR4_WORD0_SUPPORTED_ATTRS,
@@ -3953,7 +3954,13 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
-		server->caps &=
+		/*
+		 * Build the new set in a local and store it once: a reader of
+		 * server->caps during the probe, such as a remount or migration
+		 * of a mounted filesystem, must not see these capabilities
+		 * cleared and then set again one by one.
+		 */
+		caps = server->caps &
 			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
 			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
 			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME |
@@ -3961,22 +3968,22 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
-			server->caps |= NFS_CAP_ACLS;
+			caps |= NFS_CAP_ACLS;
 		if (res.has_links != 0)
-			server->caps |= NFS_CAP_HARDLINKS;
+			caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
-			server->caps |= NFS_CAP_SYMLINKS;
+			caps |= NFS_CAP_SYMLINKS;
 		if (res.case_insensitive)
-			server->caps |= NFS_CAP_CASE_INSENSITIVE;
+			caps |= NFS_CAP_CASE_INSENSITIVE;
 		if ((res.attr_bitmask[0] & FATTR4_WORD0_CASE_PRESERVING) &&
 		    !res.case_preserving)
-			server->caps |= NFS_CAP_CASE_NONPRESERVING;
+			caps |= NFS_CAP_CASE_NONPRESERVING;
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
-			server->caps |= NFS_CAP_SECURITY_LABEL;
+			caps |= NFS_CAP_SECURITY_LABEL;
 #endif
 		if (res.attr_bitmask[0] & FATTR4_WORD0_FS_LOCATIONS)
-			server->caps |= NFS_CAP_FS_LOCATIONS;
+			caps |= NFS_CAP_FS_LOCATIONS;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
@@ -4009,9 +4016,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 
 		if (res.open_caps.oa_share_access_want[0] &
 		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
-			server->caps |= NFS_CAP_OPEN_XOR;
+			caps |= NFS_CAP_OPEN_XOR;
 		if (nfs4_server_delegtime_capable(&res))
-			server->caps |= NFS_CAP_DELEGTIME;
+			caps |= NFS_CAP_DELEGTIME;
+		WRITE_ONCE(server->caps, caps);
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
-- 
2.43.0

