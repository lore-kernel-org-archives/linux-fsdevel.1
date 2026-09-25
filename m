Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53E4D6C49;
	Fri, 25 Sep 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349482; cv=none; b=rhN53/W8HiaXig6vfMH4UG0sswgvjqEnN3xRaMPz5vgx6O/s60tYgqQojPEFAoFlg//ij9AE0br3sYtUQaHQSg7ORsWmfJcA7MAjKAhlSsAkmIf3zkHBo7wDntvW+TreywKpwxmLus+cAtmEz8+Cl3X0PTllx85noB8Oo/YTg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349482; c=relaxed/simple;
	bh=aN8NV6lldBqrzb6eo7xPzq64/8+WV9ILnBET8awqJWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B/NHbjdE6x3M+Rs9QVGrqdth0aPOZzBN7ToilHIK4jqEYU7SVy5PqtKl4tOun+c5cILZryZcVFFgKGizHaflidEQCzS6QOMhyvda8qhAfDQwtug7lyw9tHAn7F9Hh1ru9FlCxramdTmAXMwAmJBU+6Erl9v12HoSwwhaO8Jh0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCV0HGGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCV0HGGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BC21F00893;
	Fri, 25 Sep 2026 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349469;
	bh=z8Sgs7XmsWWKbgKjCtJ1QYogRINsElxJu+k8QSeRCLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SCV0HGGVdIPdCCYFtQ6bt/g47QLSJOlXHVw1vSTdQvTXSA7n96nj1mMKUqyLfNJFK
	 Zyu5Y30B6B6cNeqZk/+n6JRMxemiEnFm3nFfdr2A3XoEtKjt7fBpEL92PN9EQXcbhS
	 HmSyYR2BFu7Z+e3aKrxfo5cPR7qlcXrarAbgrXyYmsUEh16z+q49wX0OvKyGTVpfUP
	 X6bzVdn51Clwcnl/EVL9tLOgsHGhqzxxH2tXiJEYysK0KANGJzadYMLG36Ysfo2Quy
	 ODcYmP4vVWsFRJTfaTk4AdUq/TsaLUvcCwEvNBVQ5XEXN7FCB7objq7+bPVMtRJWvP
	 0H+NnL50X4twA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Thorsten Blum <blum@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260919213859.24667-3-blum@kernel.org>
References: <20260919213859.24667-3-blum@kernel.org>
Subject: Re: [PATCH] initramfs: Reduce hardlink hash allocation sizes
Message-Id: <20260925-eidesstattlich-pumpen-dutzend-a7e1b4f9f331@brauner>
Date: Fri, 25 Sep 2026 17:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aN8NV6lldBqrzb6eo7xPzq64/8+WV9ILnBET8awqJWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtmzCrRJfBdqJU9JQfLC1V6hd2W4UdW6+Rod+Q2iC13
 KHOfjt3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQOTWX4Z6a0WvbXgS1h0TtL
 RaxSF3gHekQ2nZi+7E9Buhvr44cdNYwMr3lv1NRtPP3jPt8ky8nPWo78NxSxbjkv+m+eqfhnZ1Y
 BDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 19 Sep 2026 23:39:00 +0200, Thorsten Blum wrote:
> initramfs: Reduce hardlink hash allocation sizes

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] initramfs: Reduce hardlink hash allocation sizes
      https://git.kernel.org/vfs/vfs/c/b53f422491af

