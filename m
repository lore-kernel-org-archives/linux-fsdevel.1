Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F613C3F6B;
	Thu, 10 Sep 2026 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027607; cv=none; b=h5rFW0Y8RFX5vyU8QzAcG9PxF4VrnJVIkCxx2Rq6Wi1pBrRVEfQyGYEf7C3ZYV1NQcmaxj1sSNA5CNzVwGgiV/I0CeIkjWf2m7h/letxdYNtpmkKh5PbeTPhV0sRzZENPjytQzwFZ/RZo6QQzoKUnf+apLDJGRupNeNE4qLPd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027607; c=relaxed/simple;
	bh=s6pDXbQJ6bGpQKjRB3mirKnQVFqVsz5oxlx5PscAV40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YLBs5dh7mKv0RgTmf45oOznE/jA3nfzx8BatU98P+Vn5DVyCTsgUYHrIbiERuJAcb/YX9oKRVE6USshtzOk1i3u2aQulRpI9BPwnekASt9OznbO5BR2iv5yVniT5kNSXE0fHvI5ZCoSdrpMfJGvSl5g0fH8vhlAiR4dp0neAPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw+eji8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw+eji8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC41F000FF;
	Thu, 10 Sep 2026 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027605;
	bh=32sl6fctNK9b8HPuCgPO2C1sDy28MMssNMfhX+6wjj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Bw+eji8N7oQSjfpaG0nmvLhUK8XckDDNYR0SvXx6mqLSS+e6+2P7c+FlJzmisgXuN
	 5Ew2R2I5fdh2PiwoQ3TuNsim8WxmkikMTDxxO1pzWgwuwSgaewEUTSFA4lk1PUkSDX
	 AuAp/JWreAF+BkfEt9BhulKAPqLOMpsFj0FZ1vjKApoi4BOZWt6+FwJrTy/ty5ZDjR
	 TlyB8KUEWirxn0rgjk7nJnjDYhLWPhVUlApbv5D+WnkbOgdOgbEA2q5AHVRlBn4B8/
	 sHfLUqSEWinsZ1AKaVFokRh/dZWi88Eqpp8yGlc6G2lsM+zxldRO8LccuD59TPI0xt
	 QcPnAqZwJr0/g==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Benjamin LaHaise <bcrl@kvack.org>, Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260907063252.21433-1-hemanth.selam@gmail.com>
References: <20260907063252.21433-1-hemanth.selam@gmail.com>
Subject: Re: [PATCH] fs: fix typos in comments
Message-Id: <20260910-vorverlegen-eisbahn-operieren-7a15d9717bcd@brauner>
Date: Thu, 10 Sep 2026 10:06:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s6pDXbQJ6bGpQKjRB3mirKnQVFqVsz5oxlx5PscAV40=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtShUK8/XR1U8pn81rFluy/4F3UZnJrsqnl350f7cU9
 jlYnlnWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBERJkaGma+q5tmrNRdfmW9r
 nhN74eiPvswps5fe38qx/V9s5XrZxQx/+E75SG1ZrxHl+8ZyQaK26T5eQwddvmvWzi9375+woGM
 BLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 07 Sep 2026 12:02:52 +0530, Hemanth Selam wrote:
> fs: fix typos in comments

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

[1/1] fs: fix typos in comments
      https://git.kernel.org/vfs/vfs/c/21a62663d473

