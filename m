Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D9383998;
	Thu, 21 May 2026 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332803; cv=none; b=LRBsy/1nBWmTqKMP+hv46VxXztRM7dXc4LFOy62qlsQExzMZd6vxroAop+i8DX+feIhmd6QmOcEpW4tMTfKtZ4B+ryxOXOML1z3Jt14LXm2MybfXvcwNOFDctZjqKCLFtZBN1H4ZhIv+b+noldZBVoW5l160GfvSmUzc/E3oNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332803; c=relaxed/simple;
	bh=aeNSAKGDLfwiSigl/3nU/cRCtT07znTzikRQSLOqKy8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/UzvP1G5KmezWR4QztXDMUZgnBUBlSZXLaU5oUNmZ7/+dLIr2grIyNITwF+692iNFPQseBn2jVRPL+gIG7coJfdU74cTUjcMXhG31+wnnBjoHJDmWNtF9QRdlGmli7itFWQsFr6lIuokVMcWVFzdQ9NGzZ2eNATLGIk/T6xTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkjvZf0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkjvZf0g"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9B45B1F000E9;
	Thu, 21 May 2026 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332794;
	bh=Yz8NIDiKjQBFOignA1I2q1o7pz+l+3R7G7MHhhCS5aI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=GkjvZf0gkkkJdJR3HRSEf9hiktjj7ITHP67TFBtOC1HsqjNKwl+BXe+k024MxSYxL
	 yKU/7m7WjLbJmcqPIG3NnsrBSoWWyax4v1hUj1lrccqYlpMDe63B/Afje8RNhS1j+w
	 gqdOTGgogS6Os/A1WdFqfHpJ0xpQSxQaoOV7HTfbAKxXjsti1oEKBxO89gbh7S/i1K
	 gmLBX/zwKp8CexBT1tJS1Lrq+VRlD1TNQE0lrEkewSBINvv9lIUuP7qqlDAhCgybNa
	 XFW12mOyTzYoibhIYC93XXU7/lrSa20KQ+YY78JhTVNd9qGFNBU8sUdH2qRbGpPgE0
	 kaCbgM3tDk2NA==
Date: Wed, 20 May 2026 20:06:34 -0700
Subject: [PATCH 1/4] fuse: use fuse_args in try_service_main instead of
 opencoding it
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <177933241466.3536631.2548927904330465445.stgit@frogsfrogsfrogs>
In-Reply-To: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't open-code the argument array, just use the existing helpers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount.fuse.c |   71 +++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 37 deletions(-)


diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index 00b133e6234489..bbfd8355dc7f48 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -286,12 +286,7 @@ static int mount_service_child(char **argv)
 static int try_service_main(char *argv0, char *fstype, char *source,
 			    const char *mountpoint, char *options)
 {
-	char **argv;
-	char dash_o[] = "-o";
-	char dash_t[] = "-t";
-	char *mntpt;
-	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
-	int i = 0;
+	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
 	int ret;
 
 	if (!mount_service_present(fstype))
@@ -301,44 +296,46 @@ static int try_service_main(char *argv0, char *fstype, char *source,
 	if (source && source[0] == 0)
 		source = NULL;
 
-	mntpt = strdup(mountpoint);
-	if (!mntpt) {
-		perror("mountpoint allocation");
-		return -1;
+	ret = fuse_opt_add_arg(&args, argv0);
+	if (ret)
+		goto out;
+
+	if (source) {
+		ret = fuse_opt_add_arg(&args, source);
+		if (ret)
+			goto out;
 	}
 
-	if (source)
-		argc++;
-	if (options)
-		argc += 2;
+	ret = fuse_opt_add_arg(&args, mountpoint);
+	if (ret)
+		goto out;
 
-	argv = calloc(argc, sizeof(char *));
-	if (!argv) {
-		perror("argv allocation");
-		free(mntpt);
-		return -1;
-	}
+	ret = fuse_opt_add_arg(&args, "-t");
+	if (ret)
+		goto out;
+
+	ret = fuse_opt_add_arg(&args, fstype);
+	if (ret)
+		goto out;
 
-	argv[i++] = argv0;
-	if (source)
-		argv[i++] = source;
-	argv[i++] = mntpt;
-	argv[i++] = dash_t;
-	argv[i++] = fstype;
 	if (options) {
-		argv[i++] = dash_o;
-		argv[i++] = options;
-	}
-	argv[i] = 0;
+		ret = fuse_opt_add_arg(&args, "-o");
+		if (ret)
+			goto out;
 
-	if (getuid() != 0) {
-		ret = mount_service_child(argv);
-	} else {
-		/* We're root, just do the mount directly. */
-		ret = mount_service_main(argc - 1, argv);
+		ret = fuse_opt_add_arg(&args, options);
+		if (ret)
+			goto out;
 	}
-	free(argv);
-	free(mntpt);
+
+	/* If we're root, just do the mount directly. */
+	if (getuid() != 0)
+		ret = mount_service_child(args.argv);
+	else
+		ret = mount_service_main(args.argc, args.argv);
+
+out:
+	fuse_opt_free_args(&args);
 	return ret;
 }
 #endif

