Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD43542DB;
	Fri, 13 Feb 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979496; cv=none; b=R3ZjG3k8zNkMAv6qyX7bn1YxNSN1v4Gt0CUeB+w3MPfr1hFh2YIYQ7ZyyQCAowtvzegxKZqqg6j9ZwoI42iyelAkWeB4OZiwdyI4of7yRaAOvdP8st2hkhspPsAI72sAoNMkMhoJ27eXrRJPUVxEQICDdBZNpsXNoUyJmakQzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979496; c=relaxed/simple;
	bh=QRRP7xArIVfTXqzIf8NIlsyrWWBUCIjM0l4EgDMc768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2RBHUG++VJW+ZtYEabaIZuWZfCBrqlS8jQlydBDT0SbRFGtPUzdVuBVqFzVG0q5eg4B/wKjd+/8d6cSy7ZFfhW45zQLyhJaoFJMH64Z9gUV/nWhIFsguBMUI3Czi5TJWOlgWLmNVn89q93jdB/Vz47iqXLK4SMQp9Q6cA2vD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ86mcT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ86mcT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB3C116C6;
	Fri, 13 Feb 2026 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979496;
	bh=QRRP7xArIVfTXqzIf8NIlsyrWWBUCIjM0l4EgDMc768=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJ86mcT1cNuCnObS8WSWu119BBGerKwDRyHm+jdKkCs4Qd+w1X6cIUzPCjx4TCo2g
	 aCbd56Wxmwnc9niy3Fj+sjmHI8oN0FFPBMWlsJMgdqWWmjPnHhQ7QB+a4jBkGvf2ys
	 XpsU6y2vkv3TK9aD7pEhTPrpcOlt9kpIX0ufaYs+R3Se5JeC4EwbtODMsvGovffAiE
	 FyhXxAGCbMFJRnuJ7kGaHBZ7QGB6WFFxL1L5h51b5sObY05yYmamoWe7lLHQ3vhRAd
	 9WYKVvegydz032f13zCsc77/ynFa5PwQSeXb9Iggdf4/Ic0WI42TUcd0MAaqyuFzl/
	 0gK3zd3WnJ0sA==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/5] docs: proc: add documentation about relaxing visibility restrictions
Date: Fri, 13 Feb 2026 11:44:30 +0100
Message-ID: <84b3d2c6f7eadccd115c561d7291ff2f7532595e.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770979341.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org> <cover.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c8864fcbdec7..3acf178c1202 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2417,7 +2417,8 @@ so will give an `-EBUSY` error).
 If user namespaces are in use, the kernel additionally checks the instances of
 procfs available to the mounter and will not allow procfs to be mounted if:
 
-  1. This mount is not fully visible.
+  1. This mount is not fully visible unless the new procfs is going to be
+     mounted with subset=pid option.
 
      a. It's root directory is not the root directory of the filesystem.
      b. If any file or non-empty procfs directory is hidden by another mount.
-- 
2.53.0

