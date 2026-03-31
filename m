Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784483ED13B;
	Tue, 31 Mar 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950269; cv=none; b=jZ/FWOukE3qXLZmC7kvjTWR86JJD6z6wS5NwJzfaLFY/vK3LDpmbM8P0a1XE/1wCbdVSmjXo82/onJNqBG860XIARGabSl78URsAYvCP9yA30GNz5Gr4p5GSkP7MWnkxBw87lSCm1ZIwPWvo4vs5mSZ2JzR6VCIcsau/j1YsWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950269; c=relaxed/simple;
	bh=8TVQhZ4kAgMsv1XMz8dEIjPi4+kkXq06TjkdSYrrhQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRZKsN2+uEvtYgbjThumxrr/wTVwR5e7MhcZFqkgTC5ixM1EqxIO4+GJJdzgTSIy0q707G5B1Yjon/HDS9dJt6Uq19woQ3X8VAa7N6zvv6v5cIjWcVzc93Lr9vXI0pNwxRgtFsE1qkJiv+/8MpwxvDqR6xJqVEtNARmdU1t4kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB+5iTSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB+5iTSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89398C2BCB2;
	Tue, 31 Mar 2026 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774950269;
	bh=8TVQhZ4kAgMsv1XMz8dEIjPi4+kkXq06TjkdSYrrhQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IB+5iTSpZ9HiyulKAt0+OM0nG+0BtPyklSz55Au4BmPYZyGhqfhIEp5Y7mOouSOlj
	 8EFQeDPdG/HDtq+6f3g+/SeqkElg4d0+jr22QRWF9jaBa8F/RSvkfWr7itd2wCHHLZ
	 5XuP/Tr+cQL8Kinf+CG/v5MYeRz7FOdV5Biri2rgpO86TYb1180dOrSzRvSicnOmzp
	 kRYIzOZgG/IWVigVOWfKxR95XdZwTJwVQ8kc7mG1fT3MD77VgF6kwmcsZ4m68anemL
	 lftJTNpnqGXgxaXZ6fhZOQwBSPvUZK4GRVJ3QkqLBcHk7Ui2OGJjznN83Zy+Zhyjax
	 uY23Dp1MEytcQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hide file and bfile caches behind runtime const machinery
Date: Tue, 31 Mar 2026 11:44:21 +0200
Message-ID: <20260331-vertuschen-tagwerk-733db421a930@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328173728.3388070-1-mjguzik@gmail.com>
References: <20260328173728.3388070-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=brauner@kernel.org; h=from:subject:message-id; bh=8TVQhZ4kAgMsv1XMz8dEIjPi4+kkXq06TjkdSYrrhQg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSenl7x/s8KUQnv+tt3kpuF7Z8yTdCYwT3NYv7HtS9Lu zpzYuSsOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyfw7DP83iwFelHIl3tzcI /VNosxAxC1ONic8K2eGqpDv/9ArGeoa/Ei7ssvenMcSnOhx2vadzQGRhnNmdjk0P4x9cOGW7fc1 BRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 18:37:28 +0100, Mateusz Guzik wrote:
> s/cachep/cache/ for consistency with namei and dentry caches.

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] fs: hide file and bfile caches behind runtime const machinery
      https://git.kernel.org/vfs/vfs/c/1f1651d6dc2a
