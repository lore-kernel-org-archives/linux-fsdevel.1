Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E23B0AD3;
	Tue,  5 May 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958710; cv=none; b=kuQ/7esgfCrvfmTHfqvTaLoGTpeL2CV7J33hdHIxMpMc9Ee2qE0YkRoCLAGGUYAVQFe3zQ9muosfmPzLU/t9XLpZWStRNC2ZzrEzFhbw24EpjPYZUOCTtCh1deyAOtS6hRuEVf0i/eYqK5SYZQw7E1OXzRHPwfRVrBeLxasid9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958710; c=relaxed/simple;
	bh=2arsCg+uvQtYsLSsPtMc5j5SxvU5FlXgntx5wONBqUM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTO4fR8Pi7k4zgiIwmvy0UzvV93zraEJmS89sShU0GjBwc+Kt9cktNogqddNVFlQgX7JKaA88t4z9C3HbYmoNIpKioSHroOZiS+Z1SXIMB1RkSErCK04Yd6jxZmRdTzzS9AsJc8cQHklG80fEtbQdBGOOXY3RFPnlPfFT6jkU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TldjjrSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TldjjrSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC3C2BCB4;
	Tue,  5 May 2026 05:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958709;
	bh=2arsCg+uvQtYsLSsPtMc5j5SxvU5FlXgntx5wONBqUM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TldjjrSSQIMkr5xQflS6Vm2cUKFZx7DB2iJwStVqWOlNB3BxRaHXZEBIfFFvPOIMZ
	 GaqoUeBbjwyybktyyK2xVL3OGkejn7mkYKEOdyNStroGbehQUoLbDMNBfvzhjttVpo
	 MA0n9bhU/CLOyPRSSQDrClRDFipQABOpKCJIsaRNQHrgMyEiBXjlV4iPMtuLRfppPI
	 7AII/MM7chaXxi/1DQB3JYCe8k3rHuvbPrhuLFt7bI+635L8NCRUw03BqhJb2j8gLU
	 e1GtjqQxGJEpXce5djFf6UTy2W+8CaqG1vX5UYS9FcRsVe4N8WmiGXfNQaP1aHDv+e
	 et4SHFl2Ki6gg==
Date: Mon, 04 May 2026 22:25:09 -0700
Subject: [PATCH 05/10] example/single_file: fix ctime handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853775.1133612.10606468635840557496.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix the ctime initialization and updates so that it behaves like ctime
is supposed to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/example/single_file.c b/example/single_file.c
index e7da1f2933fc81..a962232d576e17 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -466,8 +466,6 @@ void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			single_file.mtime = attr->st_mtim;
 	}
 	if (to_set & FUSE_SET_ATTR_CTIME)
-		single_file.ctime = attr->st_mtim;
-	else
 		single_file.ctime = now;
 	pthread_mutex_unlock(&single_file.lock);
 
@@ -491,6 +489,7 @@ int single_file_hl_chmod(const char *path, mode_t mode,
 
 	pthread_mutex_lock(&single_file.lock);
 	single_file.mode = (single_file.mode & S_IFMT) | (mode & ~S_IFMT);
+	get_now(&single_file.ctime);
 	pthread_mutex_unlock(&single_file.lock);
 
 	return 0;
@@ -844,6 +843,7 @@ ssize_t single_file_pwrite(const char *buf, size_t count, off_t pos)
 		get_now(&now);
 
 		pthread_mutex_lock(&single_file.lock);
+		single_file.mtime = now;
 		single_file.ctime = now;
 		pthread_mutex_unlock(&single_file.lock);
 
@@ -973,6 +973,7 @@ int single_file_configure_simple(const char *filename)
 	get_now(&startup_time);
 	single_file.atime = startup_time;
 	single_file.mtime = startup_time;
+	single_file.ctime = startup_time;
 
 	if (!single_file.ro)
 		single_file.mode |= 0220;

