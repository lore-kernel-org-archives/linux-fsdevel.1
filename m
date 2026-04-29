Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637402475D0;
	Wed, 29 Apr 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474202; cv=none; b=pqdUraOK0p0V+BLME3Vm2Gr85OXB5ys2PZpw0xO7C9ImKj3Pbiv6f2ELebUmANK6WD1jWfaDGSxy9lYPJWZAWG3iBVKNfGyw2yD13FrB6qEf/TfRRxDkuQtbn5SIPB9bCa5fSuhe+31Gyh2028t+BDjr3AZK0vtHI1zHzn5sB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474202; c=relaxed/simple;
	bh=9GrPtQqv9e3wpPCMTR3Unlko5k0bJd025MhVpamF5hM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVQ4yDakDz37MBu0352MBKeUv4075FhovW4D+1mexS88+Jfwu7fVlU+RxYkH2AkgS0ltyRm9EjlrVR+FHH/ddDWLILFknctUUZAscnS9qeZrW376neAUqAzKwrih0IVtxSi+uuiCfF0+pIwqvh5fUTeS3jPdYuMkRz7ml6HnXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdkXQHRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdkXQHRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F25C19425;
	Wed, 29 Apr 2026 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474202;
	bh=9GrPtQqv9e3wpPCMTR3Unlko5k0bJd025MhVpamF5hM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JdkXQHRF3x3tUDz10wAEvLC1tSL4dPUb2FMUE6MPugmFeSOPRdGaCsEMeR77wCDN/
	 SvqhGyrpmkghBiSmQocae9zq4yBQvTsGiPetZQ82pYbKoEzryiQgwgOa1/U1kUpE9a
	 UFO/ahRQYUp1onKXU7KyxI3eoPkpXo+vDyJp1I21A8QJ2IQV5F9Hlch2loKovKrKAU
	 hmbgcvtzDN3NKvidDKITAKJBuFQnloc6AIhW4NXMhkGLLt9sRAO7e1JH2Ou+EavPO3
	 C5q/Ve+fPfKdqF/KD66yCddiZICR6VEISXYxj355w2wNXDIqQCtm9YiZbvsTh5YrtN
	 7N4agVr4D8g+Q==
Date: Wed, 29 Apr 2026 07:50:01 -0700
Subject: [PATCH 4/9] libfuse: add upper-level iomap mapping cache constraint
 code
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213318.4106384.15535510708617230463.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow high-level fuse servers to constrain the maximum size of each
iomap mapping cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/lib/fuse.c b/lib/fuse.c
index 9ca3ed7d92bfde..6b97f33abab72f 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2982,8 +2982,9 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs,
 
 	if (fs->debug) {
 		fuse_log(FUSE_LOG_DEBUG,
-			 "iomap_config flags 0x%llx maxbytes %lld\n",
-			 (unsigned long long)p->flags, (long long)p->maxbytes);
+			 "iomap_config flags 0x%llx maxbytes %lld cache_maxbytes %u\n",
+			 (unsigned long long)p->flags, (long long)p->maxbytes,
+			 p->cache_maxbytes);
 	}
 
 	return fs->op.iomap_config(p, psize, cfg);

