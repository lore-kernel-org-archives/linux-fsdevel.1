Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E634E770;
	Thu, 30 Apr 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548920; cv=none; b=a0ZNzW11Iaji/OAbKlWK4ZyAzAU/n4ZqWDXH8E031c6a23oY0pfOUiVoYJumDqmgSc5SS2gmTn8w2NH1VEI93bJ8IDbMo5RzMHhiPBudBV//p1yzmKUmldWk7sSU9pSIZ8Fv1nbGZDDeb+xLk13WkYC8kq+2F8TNEaUtxNY5ml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548920; c=relaxed/simple;
	bh=ac6leB4j3KoPOdfV83k7rh/ndEAhPLMDO2A+/AjhvOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzlUiX9rcbtRhL9RDNH8U+HLtDUoW2caCAwPHTh3yLn5yhXi0Kyqt6Ft/BI+e2zW/VGw9tcXsFgN7ip8Uy4q/sFRsQHqruVgiCGQyb718C8yY4wel2wKJ0Ddb4iQgsic2s10gdXAlArQAbLUy2hXJQ2FiMZ/PDGSSc8ta+omx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkK+A24f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkK+A24f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F0EC2BCB4;
	Thu, 30 Apr 2026 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548919;
	bh=ac6leB4j3KoPOdfV83k7rh/ndEAhPLMDO2A+/AjhvOs=;
	h=From:To:Cc:Subject:Date:From;
	b=NkK+A24fylBLjv4sQwQq0GF/PBiBqw/xH2XlqaUJU2aZovl0O8r2r4WlTqcMPPwry
	 qcY2Jc4UcV1nseDwgt2dZTByJcRjhhzX///ctLauu4aHbxYz0zKrovM5E8rtrTgB8J
	 X6C/jNuXkFG8e44mwUFaVHQaF4jQTzTsdLe9OtHGHJgk4eogLBTkpEVnzSoTEp1MOE
	 CfF/cwt0SUIcHP31C5tkoZ4xLoR0t/XSwjyjergI7FxRptWcEtotltKUffAGuU4iRy
	 QjKtbHAd2J92BGY4JMENcgyOosKrmy+4a4iVmZ1MAcfZUK63Jq1W8C5tgdLaLJUW2T
	 4iHgY8ymu5q0Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
Date: Thu, 30 Apr 2026 14:35:10 +0300
Message-ID: <20260430113512.115938-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
functions used only inside mm/userfaultfd.c static.

Mike Rapoport (Microsoft) (2):
  userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
  userfaultfd: make functions that are not used outside uffd static

 MAINTAINERS                   |    1 -
 fs/Makefile                   |    1 -
 fs/userfaultfd.c              | 2231 --------------------------------
 include/linux/userfaultfd_k.h |   36 -
 mm/userfaultfd.c              | 2238 ++++++++++++++++++++++++++++++++-
 5 files changed, 2226 insertions(+), 2281 deletions(-)
 delete mode 100644 fs/userfaultfd.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

