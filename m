Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEF31ED81;
	Thu, 21 May 2026 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332842; cv=none; b=INCD4vlCE0shcIFdXHaO6gck3l02z/4Am6zyjjGIsnWfRmnSGwQDuSIjTch0WPuOdlVdPDTvGKUnER54Mnd5gJQ77yBI6zK2uRqUy7uWM3pCM4RUH80cJdZ1vjZ66X9mGpO+8/BdCjUYr2QCZpcRofxlrXKMrkovn82LWqlQtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332842; c=relaxed/simple;
	bh=Ub78cEUAC4vatY21EATgjp3IfC8Up+/oclwlWaEldo0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYsm6owi4jhErWmpnGjEXSVzxzNMuJdhvAOfOLFFo7cjErgH3NfBJQkLyYowfCcRUmB9zbeepFlxFykFaLFd7t0C7R1T9XduL1xQtURkMyrjuqqqoobsl4hh+/kK/4qZ5vkzk5Gb9iEz6gnIKwEFyAGrTkYXQ/GGhF1vpypoieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyjoa7ph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyjoa7ph"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1FD3B1F000E9;
	Thu, 21 May 2026 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332841;
	bh=Zvj4V4b+LLKwCiUj/5Fw5HKxPV8fOS7U26ViGG2K5/M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Nyjoa7phFoQ+leGn9s3nJL5sXQoinoNuRlcl8krT0+oNs6shgzg2p41kAgBU4D9Oe
	 1m6b0LkKMwgFXAGOWdUtwwSzYCT35ffK+JJN4CtzXiwTkD8B8zOmo9EfAQxD6QGO0E
	 f2/0SZkfQ47d0+IiQmzIzoCbOrDIEZFuKgckaGPwCXt2FxC+20Nyp/GADCs1FKCw6O
	 JBSQPCjTHXVdEGyf0C1ORq6rpG6eudg8/qYCk7aT7Hpm7IuRtnZu9H26MHsrewEFwk
	 wJmoF+gA9P4EJkisH+tvroTSVU98BTrXkevdg4SnEgxvxnpHWTqzYZhLiT5K5IA8bu
	 hvKBByNtz6VNw==
Date: Wed, 20 May 2026 20:07:20 -0700
Subject: [PATCH 4/4] fuse_service: fix uninitialized variable
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <177933241518.3536631.717770834444587345.stgit@frogsfrogsfrogs>
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

Initialize the sockaddr_un variable so that subsequent comparisons won't
fail in weird ways if getsockname doesn't fill out the object.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_service.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index d14aced29e8268..4340304eaf57b9 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -388,7 +388,7 @@ static int check_sendbuf_size(int sockfd)
 static int find_socket_fd(int nr_fds)
 {
 	struct stat stbuf;
-	struct sockaddr_un urk;
+	struct sockaddr_un urk = { };
 	socklen_t urklen = sizeof(urk);
 	int ret;
 

