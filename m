Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387F371061;
	Thu, 26 Mar 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536174; cv=none; b=CPKnxbljpnxMtZtEjCr7hVwppm73ULyye6Jq6P+ks6pg+qSRS3iZS0AY8WzoZvLHzlgAoP91kWv5/rd942JfQqddlCuZCSLgNtn5wGn9IlnGCsJotbocA3p5X9NLlmT4b6RWqfsEaTdK209J8jlH7feSIfurMwYbL9d5i/aGAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536174; c=relaxed/simple;
	bh=ZbWahonD1prqMZH635hkeBmq+Ljm4UNr47KNPqKBa/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwkhN6q6FStNZZrUQEFOACLLc8VbCtaeDba2LFUqdstqHDbfgWddSFWnRF2A1fk3BMXypjrjOE9Oc7fgQnJN/JxCfd10HyBdeDuxFEmTvOs6vkw+pFf7xikbCeknUOJyg0sNmAkUdEPDeCQEuXPGtJCqx7ZTgtaGxE94l82rJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ3CyAsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ3CyAsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF2EC116C6;
	Thu, 26 Mar 2026 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536174;
	bh=ZbWahonD1prqMZH635hkeBmq+Ljm4UNr47KNPqKBa/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQ3CyAsASax+wbmanHdjgjAckGsZ4CgtlvXwF2L2pGKTNaVulbHKTYnOXiPRyY0/L
	 QVtICfng5nS1W2DxQxzqhuKuZdjOSNw/7cp5mh9xqbkV3QxvUGiVW1CYmun6hDSXGv
	 Qy7JocarKH7xWzXtS+b5ysFuiEUMTaw7u+b33Rwbf0NXrCusVtuuk/aOAzpRQJJR9K
	 ApbO8/Px0Hm3+xmxheieuWcRDajAt9rdHTAVDkZmpzGbAM74E/djWnL/3OBA4WBIEl
	 XGhe5fJbYaePl4AU1yUv2EgOsicOl1J+1JqSYDUlc3Dl4i1f+tCCk5ZmDcLnJphCAr
	 G7Tp/vwqUqGnw==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Emanuele Rocca <emanuele.rocca@arm.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 0/2] pidfds: add coredump_code field to pidfd_info
Date: Thu, 26 Mar 2026 15:42:47 +0100
Message-ID: <20260326-spuken-synergie-b606ef9a6e49@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <acE5fYOgyVUYahIn@NH27D9T0LF>
References: <acE5fYOgyVUYahIn@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=brauner@kernel.org; h=from:subject:message-id; bh=ZbWahonD1prqMZH635hkeBmq+Ljm4UNr47KNPqKBa/0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQedX2xeq5j8uYTCfMEIuYYLHBjjWljq4pXuxX0UVZYo MEs0zCso5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLpuxn+u7/Pydbes7Nv1trX 20RuHGLfMGlxEv/NB/9UWmqLhf+ce8/IcFnf6W7kGuFbJV1//ds6355hP1li9qDzzqynE3nut7J 0cgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 14:00:45 +0100, Emanuele Rocca wrote:
> This patchs series adds a new field called coredump_code to struct pidfd_info,
> as well as the relevant selftests. Note that the coredump selftests are
> currently not passing, and the following patch is needed to fix them:
> https://lore.kernel.org/lkml/ab2kI0PI_Vk6bU88@NH27D9T0LF/
> I have not included it in this series as it is not directly related to the
> coredump_code changes.
> 
> [...]

Applied to the vfs-7.1.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.pidfs

[1/2] pidfds: add coredump_code field to pidfd_info
      https://git.kernel.org/vfs/vfs/c/701f7f4fbabb
[2/2] selftests: check pidfd_info->coredump_code correctness
      https://git.kernel.org/vfs/vfs/c/7aaa4915cb69
