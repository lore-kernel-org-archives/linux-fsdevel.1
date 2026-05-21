Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71E3F1AA4;
	Thu, 21 May 2026 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390849; cv=none; b=IucMAK3jDmb4mu9G/zwlq67vrzFbeW4do+hjyPlbdeJo2IgfjZ05i/uotWozgI3b6CkEpWsqMgdEbIXDPdDIBFzh3/1wZ+hxao0VSgEGDPEpLbmhACUG35FB9lb23qgQ0cooHwT5nUZZBk6q8MtqgtGaMnpWuijlBMWZ5HTatb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390849; c=relaxed/simple;
	bh=0WnTktkzdMuTb6BZVdFA+Ss6nVXEpXnxyLaUDlyX2hQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MO/Dwkl8e/ER9rUewtlLbb/YczDKzOMFf78jnhsPLS9fzGe4MoxIs5F+r2lIk3X+R4z4U/qMAxInxxhg3uOBM20Jdyswmcp/6hbHuuZdVpC9B7N+/gDdt6oHsgASopnn6JcPWsVavh4oU/3yf0qgnPddGDxXDEd9LiMf8tN7TG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNnc3L2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNnc3L2j"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5945F1F000E9;
	Thu, 21 May 2026 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390848;
	bh=g6TXWvwOUUgLCknmvZl1dOPOfliADuH/fK+mvq6GgEw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=fNnc3L2jX9GDqm5tSyDk9faf3kd/sBQdfM03+GElF1pONdUYX8PbSDL6GIh0KM0Zc
	 BQH9c5eIUKhG4E53M16px4EJDLXrX8kxalP8vSCAMXiS3axzawWfLHE9XoFdynTk2G
	 sfOEmUmkmPNhjKtXd4nJFQL3GLBXF+M8rH9TAWjFRNyprgEpVeiY8DxhAQ3/Cqz72M
	 egXtMc8RS/7ZSBxjW9NZjUtThO2mmLunaSsNJOAeQkym3kBHa0McO7zyNeLbGcGz97
	 QX2ce0PZc4sHhZqD8eZaXuQ1/5N/E1zg+f9Rr2IWjfIO/zRf3dMtetLMEXXqygiIMU
	 cMWQK8M1VkNTA==
Date: Thu, 21 May 2026 12:14:07 -0700
Subject: [PATCH 4/4] mount/fuse_service: replace strcpy calls with memcpy
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: neal@gompa.dev, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com
Message-ID: <177939069840.35950.7032326533709352687.stgit@frogsfrogsfrogs>
In-Reply-To: <177939069755.35950.14423543819684584527.stgit@frogsfrogsfrogs>
References: <177939069755.35950.14423543819684584527.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove dangerous strcpy calls with memcpy based on the lengths we used
to compute the dynamic structure size.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_service.c   |   16 +++++++++-------
 util/mount_service.c |   12 ++++++------
 2 files changed, 15 insertions(+), 13 deletions(-)


diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 4340304eaf57b9..3e5639e609264d 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -229,7 +229,8 @@ static int fuse_service_request_path(const struct fuse_service *sf,
 				     unsigned int block_size)
 {
 	struct fuse_service_open_command *cmd;
-	const size_t cmdsz = sizeof_fuse_service_open_command(strlen(path));
+	const size_t pathlen = strlen(path);
+	const size_t cmdsz = sizeof_fuse_service_open_command(pathlen);
 	ssize_t size;
 	unsigned int rqflags = 0;
 	int ret;
@@ -260,7 +261,7 @@ static int fuse_service_request_path(const struct fuse_service *sf,
 	cmd->open_flags = htonl(open_flags);
 	cmd->create_mode = htonl(create_mode);
 	cmd->request_flags = htonl(rqflags);
-	strcpy(cmd->path, path);
+	memcpy(cmd->path, path, pathlen + 1);
 
 	size = __send_packet(sf, cmd, cmdsz);
 	if (size < 0) {
@@ -834,7 +835,8 @@ static int send_string(const struct fuse_service *sf, uint32_t command,
 {
 	struct fuse_service_simple_reply reply = { };
 	struct fuse_service_string_command *cmd;
-	const size_t cmdsz = sizeof_fuse_service_string_command(strlen(value));
+	const size_t valuelen = strlen(value);
+	const size_t cmdsz = sizeof_fuse_service_string_command(valuelen);
 	ssize_t size;
 
 	cmd = calloc(1, cmdsz);
@@ -846,7 +848,7 @@ static int send_string(const struct fuse_service *sf, uint32_t command,
 		return -error;
 	}
 	cmd->p.magic = htonl(command);
-	strcpy(cmd->value, value);
+	memcpy(cmd->value, value, valuelen + 1);
 
 	size = __send_packet(sf, cmd, cmdsz);
 	if (size < 0) {
@@ -886,8 +888,8 @@ static int send_mountpoint(const struct fuse_service *sf, mode_t expected_fmt,
 {
 	struct fuse_service_simple_reply reply = { };
 	struct fuse_service_mountpoint_command *cmd;
-	const size_t cmdsz =
-			sizeof_fuse_service_mountpoint_command(strlen(value));
+	const size_t valuelen = strlen(value);
+	const size_t cmdsz = sizeof_fuse_service_mountpoint_command(valuelen);
 	ssize_t size;
 
 	cmd = calloc(1, cmdsz);
@@ -900,7 +902,7 @@ static int send_mountpoint(const struct fuse_service *sf, mode_t expected_fmt,
 	}
 	cmd->p.magic = htonl(FUSE_SERVICE_MNTPT_CMD);
 	cmd->expected_fmt = htons(expected_fmt);
-	strcpy(cmd->value, value);
+	memcpy(cmd->value, value, valuelen + 1);
 
 	size = __send_packet(sf, cmd, cmdsz);
 	if (size < 0) {
diff --git a/util/mount_service.c b/util/mount_service.c
index b062a737e6ca28..b2a2085ac5bf57 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -527,8 +527,8 @@ static int mount_service_send_file(const struct mount_service *mo,
 				   const char *path, int fd)
 {
 	struct fuse_service_requested_file *req;
-	const size_t req_sz =
-			sizeof_fuse_service_requested_file(strlen(path));
+	const size_t path_len = strlen(path);
+	const size_t req_sz = sizeof_fuse_service_requested_file(path_len);
 	ssize_t written;
 	int ret = 0;
 
@@ -540,7 +540,7 @@ static int mount_service_send_file(const struct mount_service *mo,
 	}
 	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
 	req->error = 0;
-	strcpy(req->path, path);
+	memcpy(req->path, path, path_len + 1);
 
 	written = __send_fd(mo, req, req_sz, fd);
 	if (written < 0) {
@@ -565,8 +565,8 @@ static int mount_service_send_file_error(const struct mount_service *mo,
 					 int error, const char *path)
 {
 	struct fuse_service_requested_file *req;
-	const size_t req_sz =
-			sizeof_fuse_service_requested_file(strlen(path));
+	const size_t path_len = strlen(path);
+	const size_t req_sz = sizeof_fuse_service_requested_file(path_len);
 	ssize_t written;
 	int ret = 0;
 
@@ -578,7 +578,7 @@ static int mount_service_send_file_error(const struct mount_service *mo,
 	}
 	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
 	req->error = htonl(error);
-	strcpy(req->path, path);
+	memcpy(req->path, path, path_len + 1);
 
 	written = __send_packet(mo, req, req_sz);
 	if (written < 0) {

