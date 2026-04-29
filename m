Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0A8635D;
	Wed, 29 Apr 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474124; cv=none; b=rFnALux4mNPtkxrhssvGe63Wog4r4khooO8Tm+2a4OaKJACRfd0c3PrpxuVTh1S3PhgQ7TcOffZ52SUHi9YfxGEAuoL2rd2g1egeszq1x1OpOdDWjtcuRtR5Dqan+OoOzlenf1znMy5mz8vOJk1zJ49qKYIDGBkWCpetl77/0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474124; c=relaxed/simple;
	bh=NdR18+ZoFJOqLrtiP7odKj5LDmXYHN+e1Nq1dJZYz2A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgW4rMlIKZfdBIXrBU7oVehWUs7f8OYyYsw6LF5HfkMJSLIQNFO0A17uWYTGxXoo//QorG8ZKRYhJauRN/VijJrf+8aIYke5Us2/LKh1FOrSneOKbUXurzKzL8ArQBOaD6ZZ2hHAlAj5cDB3G7wG6NmsCQhIgoPNy31AFRYMdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhs19T54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhs19T54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1916DC19425;
	Wed, 29 Apr 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474124;
	bh=NdR18+ZoFJOqLrtiP7odKj5LDmXYHN+e1Nq1dJZYz2A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Vhs19T54NKfuZwTAxINwVJ5llP12JXhFFys7r/x2o57wu5O5op8ggp0d75QM9LI0A
	 zbAk2cm3cZLnj+znvXMoIWLck5Hyj3S6E1FdzAQDWmbMRt5XBz+jl7hJLgJEtNjDcl
	 Mkp8ujEen5JvZ7qWXjjNlRCisctssPjjRaIB6162ARVO+k1qmtSFyv3/O1BN4ipMk5
	 8saZU46XXLZ+dFwVMFI9a2Wi0/+JTLZ7kCAvIl5l1nyZLHCr9Q9k2s5mshsy2NCPBf
	 rbPv/0OnbFsWKbk0AC2cuj3Vx+Y0MBa2co3LHu36VjdO6i8zlPP+8jLAATxCjwDYIj
	 yR8L3iBaD8yuA==
Date: Wed, 29 Apr 2026 07:48:43 -0700
Subject: [PATCH 6/7] example/iomap_ow_ll: implement atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212985.4106066.8751880646165322781.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
References: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the block device supports atomic writes, we will too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/iomap_ow_ll.c |    7 +++++++
 1 file changed, 7 insertions(+)


diff --git a/example/iomap_ow_ll.c b/example/iomap_ow_ll.c
index c4edda1f9bfe40..926c25133a3a84 100644
--- a/example/iomap_ow_ll.c
+++ b/example/iomap_ow_ll.c
@@ -150,6 +150,8 @@ static int ioow_iomap_config_devices(void)
 		return ret;
 	}
 
+	single_file_configure_atomic_write();
+
 	ret = ioctl(single_file.backing_fd, BLKBSZSET, &blocksize);
 	if (ret) {
 		printf("%s: cannot set block size %u: %s\n",
@@ -435,6 +437,9 @@ static void ioow_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		goto out_unlock;
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 	if (ll.debug) {
 		fprintf(stderr,
 "%s: read offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
@@ -700,6 +705,8 @@ int main(int argc, char *argv[])
 	struct fuse_cmdline_opts opts = { };
 	int ret = 1;
 
+	single_file.fixed_size = false;
+
 	if (fuse_opt_parse(&args, &ll, ioow_ll_opts, ioow_ll_opt_proc))
 		goto err_args;
 

