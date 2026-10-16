Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79A4756D7;
	Fri, 16 Oct 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145756; cv=none; b=EMBNi4nxzL1qdy6CpuRlvXzgW0NN2nFvnYhtrqaNDpymuj2ZdVOFmglmAF6C4s79ygcZvrllQjW+9e0+0g7j0X7DzDwc7qydX8rqqa8sU0oWWxphmnBlsK+o4pGWTRzTjkBG1jTfEcd6SA5QsPeNOvkWq1ey/bnJLk1oUvEj2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145756; c=relaxed/simple;
	bh=YJi8/8S4+y0IrtyS+NCcF3w6fFahhSvuxnOzfc3OwMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6tkx4Eic1EkHj00DrkuoZe+XC4k170WEUjgUpaBDvLpJsI+eAcZbkvklLEzefjOywDXYCSeuMIMPEMN8p72zYTuUlv6hrkQVRL8P38EUTNW1ydo6NI3ZmljG0Y4P9ZfPNwIxkI6F9R1SkdN2MYjD/aV8ogRiMj9jWHJDyhVaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPcKKIjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPcKKIjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B9B1F000C4;
	Fri, 16 Oct 2026 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145753;
	bh=EKDd6Ld3IyrP9SslcudXHOzIvY3lYnIqSUyA3ThIG7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPcKKIjo4mOPvYgiuPbWrKUCIA4VaqESVAick6iZ6PPdpLMP4dC9fCnXwVZw958Sa
	 bzL5AoeM4om3eBgdDAtARKRkWCCDgyxjhOAEMvsypjzAOVbVHk3HYlUrtO1cb1WezA
	 uWO6r5NNBaPIX/MCGY1cpG1jjz0wbcfwaEa4iZVP31AOoDe7Hx7ScgDc7K3aWuwcO4
	 PFCbF1xGYfKnG64aHfIGsxN3oM7iu/JQok6OSLGbpzEQQYjRNdD1FMZO/4TxzVmZhU
	 M2oUead7VHZIZatu5PHe24g3xgtFgfBDyvkA4CvLjqiL1tglwWHrLre/sa9eijzoz7
	 qHZ0npZB91XWw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/19 for v7.4] namespace misc
Date: Fri, 16 Oct 2026 12:15:36 +0200
Message-ID: <20261016-namespace-7.4-rc1.misc-3a56b9fd31a9@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=brauner@kernel.org; h=from:subject:message-id; bh=YJi8/8S4+y0IrtyS+NCcF3w6fFahhSvuxnOzfc3OwMg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/OmTwLF/wy2Tw7rTHy3oz1sk33LCvMDJMl5k+2HJq zzWDS1KHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5Is7wT+fgqznbDygdMq+r /5bzW8lhyxMWL/nPmTfbItb91H0RNIHhv6+uicWGozv6U2UufP1XaHLtxTselels9frWFsuLO2Y kcwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- Reject uid_map, gid_map and projid_map values that don't fit in a
  u32. map_write() parsed with simple_strtoul() and truncated modulo
  2^32 on 64-bit so "4294967301 1000 1" was installed as "5 1000 1"
  without an error. Each field is parsed with kstrtou32() now and
  selftests cover the out-of-range, negative and in-range cases. This
  isn't a security fix. The truncated values were valid ids and every
  later check still applied to them.

- Annotate struct uid_gid_map's forward and reverse pointers with
  __counted_by_ptr and add a KUnit suite for inserting and sorting
  extents. insert_extent() wrote to forward[nr_extents] before bumping
  the count which the annotation flags, so it bumps first now. Two
  follow-up fixes rename the now global helpers to
  uid_gid_map_insert_extent() and uid_gid_map_sort(), since the btrfs
  self-tests have their own insert_extent(), and guard the declarations
  on CONFIG_KUNIT.

- Drop the BUG_ON() NULL checks in copy_mnt_ns() and copy_utsname().
  create_new_namespaces() always passes a valid pointer and the other
  copy_*_ns() helpers don't check either.

- Remove a dead key_put() on the create_user_ns() error path.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-7.4-rc1.misc

for you to fetch changes up to fbc59bc7f05c62b0c1607b92eaf8175e75ef755d:

  Merge patch series "userns: reject out-of-range uid_map/gid_map values" (2026-10-12 11:01:24 +0200)

----------------------------------------------------------------
namespace-7.4-rc1.misc

Please consider pulling these changes from the signed namespace-7.4-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Bill Wendling (2):
      userns: Add __counted_by_ptr attribute to struct uid_gid_map
      userns: Add KUnit test suite for uid_gid_map

Christian Brauner (6):
      Merge patch series "drop BUG_ON() NULL checks in namespace copy helpers"
      Merge patch series "userns: Add __counted_by_ptr attribute to struct uid_gid_map"
      userns: rename insert_extent() and sort_idmaps()
      userns: declare the KUnit-visible helpers whenever KUnit is enabled
      Merge patch series "Minor bugfixes for kunit userns tests"
      Merge patch series "userns: reject out-of-range uid_map/gid_map values"

Natasha Klaus (2):
      userns: reject uid_map/gid_map values that do not fit in u32
      selftests/namespaces: add uid_map/gid_map range tests

Shaojie Sun (2):
      uts: drop BUG_ON() in copy_utsname()
      fs: namespace: drop BUG_ON() in copy_mnt_ns()

Tao Cui (1):
      userns: remove dead key_put() on the create_user_ns() error path

 fs/namespace.c                                     |   2 -
 include/linux/user_namespace.h                     |  11 +-
 init/Kconfig                                       |  11 +
 kernel/Makefile                                    |   1 +
 kernel/tests/.kunitconfig                          |   4 +
 kernel/tests/user_ns_map_kunit.c                   |  98 +++++++
 kernel/user_namespace.c                            |  61 +++--
 kernel/utsname.c                                   |   1 -
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   3 +-
 .../selftests/namespaces/uid_map_range_test.c      | 299 +++++++++++++++++++++
 11 files changed, 470 insertions(+), 22 deletions(-)
 create mode 100644 kernel/tests/.kunitconfig
 create mode 100644 kernel/tests/user_ns_map_kunit.c
 create mode 100644 tools/testing/selftests/namespaces/uid_map_range_test.c
