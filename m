Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7C35836B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975241; cv=none; b=RSXquQo6l54WZ059jjdlcbYEtDLr49vVxyr0e4d6jS/zvjVJ/HN5Vr17ZT9sY2NixXhVu0xJsPE2dLevoKFo0H8tWk/kwZJ+lMYuxWomZVj0mikmMY3J19bWr4UGr2bqPlEtr/Iuuf74c32IpJds9PsZ7XUsUTztWf53/rk+gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975241; c=relaxed/simple;
	bh=jKPGtedhtgu2VRF1xgyL+njf4zprete5H8Ngt4/8sjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZwu3C+pKJS79fd5DtXfhoghxHuvT2211/KZUVtF9MRpWmA74kdzg16tATNDjwwk3mw4QljwSC4ETBcsSdQsVX9GILjGJZWzpvtuplK+cLGVL4sjivI83QRL7bNh1DdvLWw4xClG6OYbHrOznUa3E7bVuSsLZ8oOu3fkaoXL+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY5w64K6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY5w64K6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656F21F000E9;
	Thu,  2 Jul 2026 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975239;
	bh=Iqzg668QY3YMpkAnEii7nqCuhKnULgjECFvR3SY9IEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lY5w64K6YxTdbRMcyccOvu3s7AUcH6kSVf3jxIfIj0WJMHyg0FD6KJ25XEUllFRfz
	 HnFZk4C/IAdcIYEYGTPtqQcOuCclURx5XLqwc0SeQjUwsa/kRey0OWfLb2SAY5DkO/
	 5pMKHF8mygfMGKtQmx2cKddFqWHuj9AETk4LVkj0Vp4xNEFnE7OLPD87SLdA5H8Iaf
	 Ltqzdg2/GMCugh0/k2FQDwkpkGCAITSQm9oG7m35yJbfYwGzwSt2wS2IKKk6lu+D25
	 5vVfEQnhfJco2O+vTKDXskFO42E/5FGd+YzCy7Hn04MCS7WBGMqjZdYj7Rt8jX920z
	 wf0Tre6hW5U5g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
In-Reply-To: <20260701-work-kunit-nullfs-v1-1-dfa60270434f@kernel.org>
References: <20260701-work-kunit-nullfs-v1-1-dfa60270434f@kernel.org>
Subject: Re: [PATCH] kunit: use scoped_with_init_fs() in tests that resolve
 paths
Message-Id: <20260702-tortur-hymne-gerissen-360f487f1bb7@brauner>
Date: Thu, 02 Jul 2026 08:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jKPGtedhtgu2VRF1xgyL+njf4zprete5H8Ngt4/8sjQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5cbN1rzw4N6b8e/jGmRc8AzqKqoTzDuROnabdVeFxM
 HV3xV3OjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsP8nwP7WjV/RFiPCv3JvH
 D56NcH/64O62huAovR55MUszn31b+RkZrj93nGHz4ijXNOl/Rc/4LvDK2zzccd72ZRenavjP6b+
 a+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 01 Jul 2026 16:54:23 +0200, Christian Brauner wrote:
> kunit: use scoped_with_init_fs() in tests that resolve paths

Applied to the vfs-7.3.kthread branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.kthread branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.kthread

[1/1] kunit: use scoped_with_init_fs() in tests that resolve paths
      https://git.kernel.org/vfs/vfs/c/804dd204728c

