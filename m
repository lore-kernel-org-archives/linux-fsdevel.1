Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FF3DDDDE;
	Wed, 19 Aug 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181009; cv=none; b=lRAmrTWlZqNScsUeAvEJQZcVuGXac/42LDbmlEvWY2sN6WvHBJNYRs+89ZRVRUsNxuCh4hfNN+RtSY4nzlWIFfZrtbqKPbsLWjLSoCxanf7XvXm9wyOAVT1uSi1Xi4kyG5ojS/5YbGLpTL58uCnZ4CAdmH2JBy8JZMTPC+gdhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181009; c=relaxed/simple;
	bh=g0a1kYV53viXcxL/lVIPR2fuUykenxBNOGfzhwh0UJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLi8SyAodxyWfNTALk5E9XgFWHzacUJBJzgfnyvFpWC6Sj8I3hbsa6Kr8zksRJgS7FMimlDiwxo0bMHqiSxMvpRF4QIVnSR9jgEufOYBSNfvp85rYrHWo1DF2ivroo1RnUIvhAvRoU10ELby/RGp5OOrCXqDaZHr3Sld4MZEkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEuB932n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEuB932n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D71A1F000E9;
	Wed, 19 Aug 2026 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181008;
	bh=0bW5IEgJKmSIJtwmTEEMkv73JLFJ3IXzsjpXfuyidoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LEuB932nM/UQEfWfWfw+dOgybuedzZaOhO1071ixqoQoMGoiYm2QscBoR/y1Lezs+
	 NvT56PSoLqff/NUiucZuYKdzV49MAfi00OrwzpOdkarTrTs7Pry9k1zO3t1p9eF89Y
	 awmjvXy/9IWizfJB3QQe5eIL2qWXTcU0fV+UNqvKIzzwNT2mbySQ19T8c/NqinCiLA
	 ow6UDBbGwBpzydM9cL+k3npIWi4glJWVz4PlywMdvwup0S5lpZwSBYlnLwxAiLfFAu
	 WeJ6kcitLnoLnFQxYwGiquxV/WtjI0r396xQBGdFFvQMjxH6aFWOLhRaa3lLWqgBcJ
	 Dmx30y1DHJEUA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:19 +0200
Subject: [PATCH v2 02/22] coredump: refuse negative skips
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g0a1kYV53viXcxL/lVIPR2fuUykenxBNOGfzhwh0UJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9TP7f+9yQT8+WvJ+wQ0jY2mNB/LONcQnJeyOkDJ
 24lCISXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE/xrD/0q2Cxy3aozfKVUX
 5X0+Zqu+eOeEHYf2dJ5SnJnv351ec5eR4fgWa6cL2ksdZ3KVXt50XN92X1DWlz9iInYXiq5Kt3w
 /zQwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The dump_skip_to() helper calculates a relative skip based on the
absolute positon of the coredump:

	cprm->to_skip = pos - cprm->pos;

That's easy to mess up for callers and one already did. This risk
endless zero PAGE_SIZE loops or overwriting already written coredump
data thereby corrupting the dump.

I don't think skipping backwards has any meaning. So warn and refuse.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..ac4e922c9cb9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1261,6 +1261,8 @@ EXPORT_SYMBOL(dump_emit);
 
 void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
 {
+	if (WARN_ON_ONCE(pos < cprm->pos))
+		return;
 	cprm->to_skip = pos - cprm->pos;
 }
 EXPORT_SYMBOL(dump_skip_to);

-- 
2.53.0

