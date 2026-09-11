Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F547F3B9;
	Fri, 11 Sep 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131570; cv=none; b=lSSIb6Bz+0e1JVeiGQaKMn7hCppZ3yA0qkLqqMnoDAXVjJwbq6ibPt0+NWy1SLa4+YzvgCW32s3BrZVXbmifG0HuDDP1J4u6SGYEXvuW2lNEgwb7uTxfYW4B5gmgnstDbqUkbsI1GD8Z0VyzVZ3X/19p2pjwb/E48BYnal1wHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131570; c=relaxed/simple;
	bh=kVJLVB91b38E+NuzMnTZBhgCeuiMY+zCKClKtM9ttZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmJLPmirYr8Cf+oLA+4pSRdSgEAl0vdZU5FCVqDtLk1M5In0HQz5LbYTIF9VVs7z3bo/ItsgjaE7L6EQwHpTMcQR32MlTn+dTxEib+A4AZR7+VfFPWE2V+iTtN6/xgWObW8ZW6k85+dZGVCyJuRKch2UzURDK85n/zEDR0YYP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+js85Wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+js85Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E141F00898;
	Fri, 11 Sep 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131561;
	bh=a6ID2VzU021z/DQrttxikdtMPyuJ3RNGKqzWvnXkcGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+js85WimAWBdZM9HMNltePzcVJZLeyLiBmXCBUmToHOfrPk0mHh0+5O8YNgdLLys
	 R2XA/4CiQBPWfsJz/pwj7T1MUyI3nfnENweFTdm/H4i8dHqLfGc7uyD+Sp0FE2ql1d
	 JUT125E2ycfncJwKNH+wbG2S8xf3t2OfXyhYjfAgrT7BVQKyMPZkVXyf6syNPQ1f2N
	 17qqO1yJHPF/eMvJXWsvfyQ2FbF/UD7UAXUWBusYGlXP0rH5Rj85vhkb5C5KclaNwE
	 HLaF39xzILXubHhzskQp1LHa3OOg5A1JA6Tufn2mXUZu6kFHOgohTiXLd/2jmct4Kh
	 T//p1vTwC5dFA==
From: Christian Brauner <brauner@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	kernel test robot <lkp@intel.com>,
	codemender-patching+linux@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/2] userns: declare the KUnit-visible helpers whenever KUnit is enabled
Date: Fri, 11 Sep 2026 14:58:40 +0200
Message-ID: <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=brauner@kernel.org; h=from:subject:message-id; bh=kVJLVB91b38E+NuzMnTZBhgCeuiMY+zCKClKtM9ttZw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQt/s3qtoZJ9nt4nUvBg3yPiAIO179rzc9uYXik9DPTe N3R0y+cOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS/Jzhf/RXXcv657YPxDju yCRVir/aNuVHUk7C/Z+LvU46CJ/Xz2Fk6Pqe3+Hq52T6RvucRpJiloW0VlTo0h0Mc/aLmRvaVoe zAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

VISIBLE_IF_KUNIT drops the static qualifier whenever CONFIG_KUNIT is
enabled but the prototypes for the two helpers it exposes are only
declared when CONFIG_USER_NS_MAP_KUNIT_TEST is set.

  kernel/user_namespace.c:787:22: warning: no previous prototype for 'insert_extent' [-Wmissing-prototypes]
  kernel/user_namespace.c:860:22: warning: no previous prototype for 'sort_idmaps' [-Wmissing-prototypes]

Guard the declarations on CONFIG_KUNIT so they match the definitions.

Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609111048.yhHILE11-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609111305.ta3EOA2x-lkp@intel.com/
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/user_namespace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 637cd7e91a45..91232053775d 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -208,11 +208,11 @@ extern bool in_userns(const struct user_namespace *ancestor,
 extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
 
-#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
 				     struct uid_gid_extent *extent);
 extern int uid_gid_map_sort(struct uid_gid_map *map);
-#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
+#endif /* CONFIG_KUNIT */
 
 #else
 
-- 
2.53.0

