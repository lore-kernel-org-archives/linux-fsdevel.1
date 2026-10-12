Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E664A0939;
	Mon, 12 Oct 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819587; cv=none; b=oGn/AAv2yQJvcHhIrIJqK04km9nXJ94q5kz2WPgtszvoIYUYHymVBDy41NjIOX/8cmcZqt5+9dZJoqK4X0un+p3fHO1xBMQrc4m5ziWTj/FADl42ovflwW109VZ+RcEsolqpQIf938gQh5K7/ZGIFytsd+HoffI+592dj+X/NYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819587; c=relaxed/simple;
	bh=tFKFSpgvjkw7SF2mKklfKeGU6Erx3SYE9+XoQ2/P8Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeoZAjHvNVof2wnR0E24/sSPZc0o9fkAseDrtWCq4TECGKAxAfBWpw4KfIiQMbXwlnFlytR2xqMRTAefyrPggj5HzP5nrD8UAAnhF8usr4DpHSe+1qoDe/kalaqT9oDLXoe4wJuESv68U7YP49D2IJItUVLbb2vktPa+jl8n9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etTQZq2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etTQZq2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C11F0089B;
	Mon, 12 Oct 2026 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819586;
	bh=VlrnUtZP/a1YR1tijGd92/VIWBNyIUCVd6WCaYKAR0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=etTQZq2EWqTZD1wrqzNxH2oZds89kfNQXPHoM5KN+tTQwwFE9sm0FdBG+1UOxpCG6
	 ByjkKiwrT3HlHYKXc3d8JEMV3q7c9fKKrUCkovsd2MZFlcQqe20MMsYrcoVoKVKtic
	 dLYrEHXMJF/JfCL3W+0TxEhgbaljgWZO7tXJR4Ee2K1rjP5ZtmIWS2unhmUT1Oz4EI
	 DGlrqZ+bL5ZxajvE4iZaTdgoFqFdDjKNYEZvoBUN9hCZp7PoxupAG2FwzLSUdeYIq6
	 c42xoegOkmu0EYw4epbXhnZtGfI17T67Efh8jBHEDJujBBVHkO/sg0iSnt2b9MIK3b
	 lZrtkc2Xlhahw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:21 +0200
Subject: [PATCH 8/9] ipc: free the namespace after a grace period
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-8-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tFKFSpgvjkw7SF2mKklfKeGU6Erx3SYE9+XoQ2/P8Tg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a/d1Pxo1+/WfuEbLmGPtqkfOP9msZSIT/UHrd8PP
 avsbUpEOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbif56R4eKrJ4t2mBxoYdq7
 /y9v5hr75+vP/L+7YcPRtTYP1xhpMTgw/A/s3+spuePiMeYJmyLU4x9N6nj09+byvCfKHRM5mns
 PKvEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit 74b24a582e1f ("ipc: support ns lookup") put_ipc_ns()
removes the namespace from the namespace tree before it hands it to
free_ipc(). But free_ipc_ns() still frees it with a plain kfree(). The
namespace tree is walked under rcu_read_lock() though. lookup_ns_id(),
listns() and the decoding of nsfs file handles find namespaces
locklessly and read their reference counts.

Every other namespace type frees with kfree_rcu() or call_rcu() after
ns_tree_remove(). The ipc namespace got away with kfree() because
free_ipc() waits for a grace period for the mqueue mount before it frees
the batch. That grace period goes away in the next patch.

So free the namespace after a grace period of its own.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 ipc/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 1e71353bdb4a..76df11e0b134 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -164,7 +164,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_common_free(ns);
-	kfree(ns);
+	kfree_rcu(ns, ns.ns_rcu);
 }
 
 static LLIST_HEAD(free_ipc_list);

-- 
2.53.0

