Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AE231829
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246042; cv=none; b=mo1suA6h98buWOQwaOZFMRtOYHWvy018R2B6kNYoTej/HYlIaJMaZHJT30DXW/uyOHu0px1bRBMXncHQQeqQPhIh+gdlver0M9ykHder3szNenaK9bJJ1SkKKpUMvVyj7bH0gQRsx0RE2COHVvK9w1dZoc/NHztVgXrgeJ633bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246042; c=relaxed/simple;
	bh=7+LHazxkAgwNmBkyXWX4W1yIMeOFciOMMCWld1fjn7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlNROEs3KS0kEgikuUVNI0MnRPtpWXAJsz60HHnu17ubxUU34TkP9DlazyjcFlJXN2AI1awVq8byMjeGzxU3QpfWzas36UhO2luUSS215Jlm9SzWO4L9caTfXu3prSsLMnsKTGMOmWBCniRKmjymYlUCVmpLYKzuGeXbhEryY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXIulejW; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXIulejW"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8aecf8568b6so19144537b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246037; x=1791850837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CmXvJbF7d5P0B45tqqWI6Eg5lNcyJHkIy6TRYrGH+0=;
        b=RXIulejW5IGq3zRyVJ7EjCKFftIZnYpyRx4MK++lXyYcb0TQqYBaA/6670+9uwcZ+Z
         inhzjLito0MGn2/F6UKKBAVvFPH5CMsLlMKZA/LeYoov7y/3PoYTBLogA41GqT3ATXE9
         MdfInv0efUojEl6REG3nXjk+Xn5V7x//QnYqr2cwxBxaGaDBMKfnSRhkPXnJYzHfkD30
         K2uzA3E0+KNtBqNbdcqVFqsiunP5f6P13ME5mvynXujsqOdrUbin6gOmfy1YUcsIh3hG
         Dxgi9RdVqJV+Q2XtqpnnRhDSSkzA8ZcQLThLR+HGZTN1rSeOwQwf3OpyDEbPzpcnXR9N
         WUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246037; x=1791850837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CmXvJbF7d5P0B45tqqWI6Eg5lNcyJHkIy6TRYrGH+0=;
        b=II13uwfMpOiDoBFqklDGHnH3Wc6qoOZWqAntEKXlZGwbMOSmNMn/oonB0zvahn8aKa
         35uxKO+Out55NCJ6Z1ZlyHYKr9IZMAaqf2cPOTQm0gHdzGrMGFW9lLz4MDXT65D3ozUM
         YCt8zGLANWKNlL+KdoyDQAz+15wppJwogTiU6zAlOSyPCGNLqZELktAFraTIeW7QCvtO
         iCVAw1RJ7ZKcr2/EGz65lrRRtqxqXhtWOhesfO+neNlhAPGiUc6qoV+sjh6s8rNPAohW
         BOyiopg/WTobEpGsNdn39NBaatnAwgN0QBfqfxqnsI/7ftn2KxVWq5KZz7d3fLkYVUge
         bhBQ==
X-Gm-Message-State: AFq9FYIJ0PmodwWt3C55MxXoJ3MADLhWbPm2B/W9GKVcYqgqLHuA/3jl
	gh8JnPp4M+0Wp62n3QKFt+pCMKitmB475FBSCCGpSHPl+TOBh1c0xXdF
X-Gm-Gg: AYBFou2kn4JRt3uWomB9GCiwLX/o5lOAN8mSVcXlQAv+Vp4lyztj7NyUPl/PtSTwNzB
	16h5mw8Mii12PYkqQqmk+UzVjxOb9hFiHKNfScfmi51rVjoxZPsaesyAGwjdOInWRlpWBzYvMeK
	2AIGrkeosMT39V7UQuXemO0GLdmIlmNd335HAf4TCL+NUTn19PqTRRWyRpqnD5dGqW1frf2b63t
	YRTEKNVd/xn6NIO6MRaXxFhYFHdrOsusB+hdaymrhxOHbC5fTum/emBYzHFY+SAjeoygkm/egH+
	bQApTivAxycWKTs6k14bWflN7yduJW/2SCo78NeJGGJ9eQFasrjwJAh+ppJUkJusJOQjG29IIoa
	GyQeD8w8vGQqdGGFZ4PLwi+yUioYYDFxHBCT32iXWXZUApkROIWUAhEDACCYoFRTU1TIiRzahKd
	Wpv1XvM/qUYN90GpJCazTlB+odHWcQU0ZFSr0SY9Efo6k6Dmy4/MFSLItsahU2e2swEmDvKbJXm
	g==
X-Received: by 2002:a05:690c:660f:b0:8ad:7131:9197 with SMTP id 00721157ae682-8ae399a3f8cmr45298337b3.25.1791246036899;
        Mon, 05 Oct 2026 17:20:36 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 03/12] landlock: convert ancestor walk to vfs_walk_ancestors()
Date: Mon,  5 Oct 2026 20:20:10 -0400
Message-ID: <20261006002020.2890858-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded jump_up/follow_up loop of
is_access_to_paths_allowed() with one vfs_walk_ancestors() call, moving
the loop state into a struct passed to the callback.

follow_up() ignores the mount's disappearance, so a concurrent umount
could make the walk operate on an unaccounted mount.  The walker steps
with choose_mountpoint(), which revalidates against mount_lock.  The
disconnected-directory handling is otherwise preserved: MNT_INTERNAL
roots allow and stop, other disconnected roots resume at their mount
root.  Rule evaluation is preserved exactly: disconnected roots that
were positions of the old loop (the walk's start, the parent of a
disconnected subtree) keep being matched against rules, while the
disconnected mountpoints the walker newly visits on a mount crossing
are skipped via VFS_WALK_POS_MOUNTPOINT, as the old loop never
consulted them.

Co-developed-by: Song Liu <song@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c | 265 +++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 132 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index cab43892ec2f..369e2e9c83ad 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -751,6 +751,107 @@ static void test_is_eacces_with_write(struct kunit *const test)
 #undef IE_TRUE
 #undef IE_FALSE
 
+struct landlock_walk_state {
+	const struct landlock_domain *domain;
+	struct layer_masks *layer_masks_parent1, *layer_masks_parent2;
+	const struct layer_masks *layer_masks_child1, *layer_masks_child2;
+	access_mask_t access_request_parent1, access_request_parent2;
+	access_mask_t access_masked_parent1, access_masked_parent2;
+	bool child1_is_directory, child2_is_directory;
+	bool allowed_parent1, allowed_parent2, is_dom_check;
+};
+
+static int check_access_path_walk(const struct path *const ancestor,
+				  const unsigned int pos_flags,
+				  void *const data)
+{
+	struct landlock_walk_state *const state = data;
+	struct landlock_id id = {
+		.type = LANDLOCK_KEY_INODE,
+	};
+
+	if (unlikely(pos_flags & VFS_WALK_POS_DISCONNECTED)) {
+		if (likely(ancestor->mnt->mnt_flags & MNT_INTERNAL)) {
+			/*
+			 * Stops and allows access when reaching disconnected
+			 * root directories that are part of internal
+			 * filesystems (e.g. nsfs, which is reachable through
+			 * /proc/<pid>/ns/<namespace>).
+			 */
+			state->allowed_parent1 = true;
+			state->allowed_parent2 = true;
+			return VFS_WALK_STOP;
+		}
+		/*
+		 * The old loop never visited the mountpoints a mount
+		 * crossing lands on: don't match them against rules.  Other
+		 * disconnected roots keep being matched below, as before.
+		 */
+		if (pos_flags & VFS_WALK_POS_MOUNTPOINT)
+			return VFS_WALK_CONTINUE;
+	}
+
+	/*
+	 * If at least all accesses allowed on the destination are already
+	 * allowed on the source, respectively if there is at least as much as
+	 * restrictions on the destination than on the source, then we can
+	 * safely refer files from the source to the destination without
+	 * risking a privilege escalation.  This also applies in the case of
+	 * RENAME_EXCHANGE, which implies checks on both direction.  This is
+	 * crucial for standalone multilayered security policies.  Furthermore,
+	 * this helps avoid policy writers to shoot themselves in the foot.
+	 */
+	if (unlikely(state->is_dom_check &&
+		     no_more_access(state->layer_masks_parent1,
+				    state->layer_masks_child1,
+				    state->child1_is_directory,
+				    state->layer_masks_parent2,
+				    state->layer_masks_child2,
+				    state->child2_is_directory))) {
+		/*
+		 * Now, downgrades the remaining checks from domain handled
+		 * accesses to requested accesses.
+		 */
+		state->is_dom_check = false;
+		state->access_masked_parent1 = state->access_request_parent1;
+		state->access_masked_parent2 = state->access_request_parent2;
+
+		state->allowed_parent1 =
+			state->allowed_parent1 ||
+			scope_to_request(state->access_masked_parent1,
+					 state->layer_masks_parent1);
+		state->allowed_parent2 =
+			state->allowed_parent2 ||
+			scope_to_request(state->access_masked_parent2,
+					 state->layer_masks_parent2);
+
+		/* Stops when all accesses are granted. */
+		if (state->allowed_parent1 && state->allowed_parent2)
+			return VFS_WALK_STOP;
+	}
+
+	if (get_inode_id(ancestor->dentry, &id)) {
+		state->allowed_parent1 =
+			state->allowed_parent1 ||
+			unmask_layers_fs(state->domain, id,
+					 state->access_masked_parent1,
+					 state->layer_masks_parent1,
+					 ancestor->dentry);
+		state->allowed_parent2 =
+			state->allowed_parent2 ||
+			unmask_layers_fs(state->domain, id,
+					 state->access_masked_parent2,
+					 state->layer_masks_parent2,
+					 ancestor->dentry);
+	}
+
+	/* Stops when a rule from each layer grants access. */
+	if (state->allowed_parent1 && state->allowed_parent2)
+		return VFS_WALK_STOP;
+
+	return VFS_WALK_CONTINUE;
+}
+
 /**
  * is_access_to_paths_allowed - Check accesses for requests with a common path
  *
@@ -803,16 +904,16 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 			   struct landlock_request *const log_request_parent2,
 			   struct dentry *const dentry_child2)
 {
-	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
-	     child1_is_directory = true, child2_is_directory = true;
-	struct path walker_path;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
-	};
-	access_mask_t access_masked_parent1, access_masked_parent2;
 	struct layer_masks _layer_masks_child1, _layer_masks_child2;
-	struct layer_masks *layer_masks_child1 = NULL,
-			   *layer_masks_child2 = NULL;
+	struct landlock_walk_state state = {
+		.domain = domain,
+		.layer_masks_parent1 = layer_masks_parent1,
+		.layer_masks_parent2 = layer_masks_parent2,
+		.access_request_parent1 = access_request_parent1,
+		.access_request_parent2 = access_request_parent2,
+		.child1_is_directory = true,
+		.child2_is_directory = true,
+	};
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -826,37 +927,39 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	if (WARN_ON_ONCE(!layer_masks_parent1))
 		return false;
 
-	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
+	state.allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
 
 	if (unlikely(layer_masks_parent2)) {
 		if (WARN_ON_ONCE(!dentry_child1))
 			return false;
 
-		allowed_parent2 = is_layer_masks_allowed(layer_masks_parent2);
+		state.allowed_parent2 =
+			is_layer_masks_allowed(layer_masks_parent2);
 
 		/*
 		 * For a double request, first check for potential privilege
 		 * escalation by looking at domain handled accesses (which are
 		 * a superset of the meaningful requested accesses).
 		 */
-		access_masked_parent1 = access_masked_parent2 =
+		state.access_masked_parent1 =
 			landlock_union_access_masks(domain).fs;
-		is_dom_check = true;
+		state.access_masked_parent2 = state.access_masked_parent1;
+		state.is_dom_check = true;
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
 			return false;
 		/* For a simple request, only check for requested accesses. */
-		access_masked_parent1 = access_request_parent1;
-		access_masked_parent2 = access_request_parent2;
+		state.access_masked_parent1 = access_request_parent1;
+		state.access_masked_parent2 = access_request_parent2;
 		/*
 		 * Simple requests have no parent2 to check, so parent2 is
 		 * trivially allowed.  This must be set explicitly because the
-		 * get_inode_id() gate in the pathwalk loop may prevent
+		 * get_inode_id() gate in the walk callback may prevent
 		 * landlock_unmask_layers() from being called (which would
 		 * otherwise return true for NULL masks as a side effect).
 		 */
-		allowed_parent2 = true;
-		is_dom_check = false;
+		state.allowed_parent2 = true;
+		state.is_dom_check = false;
 	}
 
 	if (unlikely(dentry_child1)) {
@@ -872,8 +975,8 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		if (handled && get_inode_id(dentry_child1, &id))
 			unmask_layers_fs(domain, id, handled,
 					 &_layer_masks_child1, dentry_child1);
-		layer_masks_child1 = &_layer_masks_child1;
-		child1_is_directory = d_is_dir(dentry_child1);
+		state.layer_masks_child1 = &_layer_masks_child1;
+		state.child1_is_directory = d_is_dir(dentry_child1);
 	}
 	if (unlikely(dentry_child2)) {
 		struct landlock_id id = {
@@ -888,118 +991,16 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		if (handled && get_inode_id(dentry_child2, &id))
 			unmask_layers_fs(domain, id, handled,
 					 &_layer_masks_child2, dentry_child2);
-		layer_masks_child2 = &_layer_masks_child2;
-		child2_is_directory = d_is_dir(dentry_child2);
+		state.layer_masks_child2 = &_layer_masks_child2;
+		state.child2_is_directory = d_is_dir(dentry_child2);
 	}
 
-	walker_path = *path;
-	path_get(&walker_path);
 	/*
 	 * We need to walk through all the hierarchy to not miss any relevant
-	 * restriction.
+	 * restriction.  Reaching the real root without a grant from each
+	 * layer denies access.
 	 */
-	while (true) {
-		/*
-		 * If at least all accesses allowed on the destination are
-		 * already allowed on the source, respectively if there is at
-		 * least as much as restrictions on the destination than on the
-		 * source, then we can safely refer files from the source to
-		 * the destination without risking a privilege escalation.
-		 * This also applies in the case of RENAME_EXCHANGE, which
-		 * implies checks on both direction.  This is crucial for
-		 * standalone multilayered security policies.  Furthermore,
-		 * this helps avoid policy writers to shoot themselves in the
-		 * foot.
-		 */
-		if (unlikely(is_dom_check &&
-			     no_more_access(
-				     layer_masks_parent1, layer_masks_child1,
-				     child1_is_directory, layer_masks_parent2,
-				     layer_masks_child2,
-				     child2_is_directory))) {
-			/*
-			 * Now, downgrades the remaining checks from domain
-			 * handled accesses to requested accesses.
-			 */
-			is_dom_check = false;
-			access_masked_parent1 = access_request_parent1;
-			access_masked_parent2 = access_request_parent2;
-
-			allowed_parent1 =
-				allowed_parent1 ||
-				scope_to_request(access_masked_parent1,
-						 layer_masks_parent1);
-			allowed_parent2 =
-				allowed_parent2 ||
-				scope_to_request(access_masked_parent2,
-						 layer_masks_parent2);
-
-			/* Stops when all accesses are granted. */
-			if (allowed_parent1 && allowed_parent2)
-				break;
-		}
-
-		if (get_inode_id(walker_path.dentry, &id)) {
-			allowed_parent1 =
-				allowed_parent1 ||
-				unmask_layers_fs(domain, id,
-						 access_masked_parent1,
-						 layer_masks_parent1,
-						 walker_path.dentry);
-			allowed_parent2 =
-				allowed_parent2 ||
-				unmask_layers_fs(domain, id,
-						 access_masked_parent2,
-						 layer_masks_parent2,
-						 walker_path.dentry);
-		}
-
-		/* Stops when a rule from each layer grants access. */
-		if (allowed_parent1 && allowed_parent2)
-			break;
-
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
-				/*
-				 * Stops and allows access when reaching disconnected root
-				 * directories that are part of internal filesystems (e.g. nsfs,
-				 * which is reachable through /proc/<pid>/ns/<namespace>).
-				 */
-				allowed_parent1 = true;
-				allowed_parent2 = true;
-				break;
-			}
-
-			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
-			 */
-			dput(walker_path.dentry);
-			walker_path.dentry = walker_path.mnt->mnt_root;
-			dget(walker_path.dentry);
-		} else {
-			struct dentry *const parent_dentry =
-				dget_parent(walker_path.dentry);
-
-			dput(walker_path.dentry);
-			walker_path.dentry = parent_dentry;
-		}
-	}
-	path_put(&walker_path);
+	vfs_walk_ancestors(path, check_access_path_walk, &state, 0);
 
 	/*
 	 * Check CONFIG_SECURITY_LANDLOCK_LOG to enable elision of
@@ -1007,24 +1008,24 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	 * dead code elimination.
 	 */
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
-	if (!allowed_parent1 && log_request_parent1) {
+	if (!state.allowed_parent1 && log_request_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent1->audit.u.path = *path;
-		log_request_parent1->access = access_masked_parent1;
+		log_request_parent1->access = state.access_masked_parent1;
 		log_request_parent1->layer_masks = layer_masks_parent1;
 	}
 
-	if (!allowed_parent2 && log_request_parent2) {
+	if (!state.allowed_parent2 && log_request_parent2) {
 		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent2->audit.u.path = *path;
-		log_request_parent2->access = access_masked_parent2;
+		log_request_parent2->access = state.access_masked_parent2;
 		log_request_parent2->layer_masks = layer_masks_parent2;
 	}
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
-	return allowed_parent1 && allowed_parent2;
+	return state.allowed_parent1 && state.allowed_parent2;
 }
 
 static int current_check_access_path(const struct path *const path,
-- 
2.55.0

