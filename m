Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2B3EFFA5;
	Thu, 28 May 2026 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972051; cv=none; b=E5/mOFsL+m42LXPA1BWGI2FNXoXDX5IDzlRhikrfheKytH8agwNCdIrxZyeEmOzJmO2DGc9ZkqI9c9s+yrT29SOJq9t3Hc/mT89yfc+Vh6odtJevpYOziwecAszwbKeI6A6oAPZHHeOqGR2nuakGWaaIkc4xxcYILCL9Q1HwH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972051; c=relaxed/simple;
	bh=Oa1HoFEw64BsPeT7yDtHgnF7tTwHRMvv0oc7mgif2rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJUGg1Vfa+93DqIqUf/8E1Ypz+Zf/rWYl1ngWvxOiTPy16fFfW2n0t6XkNK3ejXYxaBa0J1tL5DdtXVszjVB9+VaIujl4M3hRMJx8QpdvXlNf1qo51+9WudsyXQMli68JjSMikGQVta4uPoze5wv1H0Q1rP2LYgqccBvjd3EO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr50e5Zk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr50e5Zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95C11F000E9;
	Thu, 28 May 2026 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972049;
	bh=Z7ovfoGOo2NP1JqGdgc2hdZRyMJVSFcMNZOtQKDLX7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cr50e5ZkujvdMb5St7wbJuMNt9/yC88PVimA7Zp7Il236BzdlM6gEb9M3/Wn7n+QP
	 FD/JU0ya/i4upVP12uMNXU+CLCoHIywiKle/A1xRGYf4tp2nufulkzHVccC1vjp/T4
	 vhhD6zrDqa/J6mXqzNc6buI/LB9n1nbMxzf1of88QsE5l47gaygaiL7lJW0i/SPRgP
	 6xohO/CXxclyf/cAPcN3NTWpbFvAcKDcow15nTrTumxKegsQNJmoKsd7A/mMDUYbq5
	 Y1096j3aqSeEmtr0Hjnj1RwsumOgPKC8z0EKeWU7vFzrOSq3bF7leYLfhvXHDOy49F
	 hmswlUBaZMQiQ==
From: Christian Brauner <brauner@kernel.org>
To: w15303746062@163.com
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	viro@zeniv.linux.org.uk,
	alex.aring@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
Date: Thu, 28 May 2026 14:40:36 +0200
Message-ID: <20260528-sonst-relief-grabbeigaben-3e20f9a3f8bb@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523135210.590928-1-w15303746062@163.com>
References: <20260523135210.590928-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=Oa1HoFEw64BsPeT7yDtHgnF7tTwHRMvv0oc7mgif2rc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJmJ9Wf903VXkxG9t8SbboF4Z/nfrbrnsZHrokdMth+ cS/MTlXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS7MnIcOGy9r01b1z2/2L6 zD37vnXh0mc/YkM2nVO+HNGYo/Y4fwIjwzrhX+Y8HPZpU/fH/l7mfyxwyq11u24lzvWQ0++6qMQ pzAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 23 May 2026 21:52:10 +0800, w15303746062@163.com wrote:
> A SOFTIRQ-safe to SOFTIRQ-unsafe lock order deadlock can occur in
> send_sigio() and send_sigurg() when a process group receives a signal.
> 
> When FASYNC is configured for a process group (PIDTYPE_PGID), both
> functions use read_lock(&tasklist_lock) to traverse the task list.
> However, they are frequently called from softirq context:
> - send_sigio() via input_inject_event -> kill_fasync
> - send_sigurg() via tcp_check_urg -> sk_send_sigurg (NET_RX_SOFTIRQ)
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
      https://git.kernel.org/vfs/vfs/c/00633c468382
