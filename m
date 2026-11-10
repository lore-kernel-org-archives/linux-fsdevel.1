Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319709;
	b=ANUeyD9hMVsSBwkZCi/fixrhYexlEFm7SclCnXWOQJCZZvnPOyhhUa+Hgu1W46dshxW7
	 qVy2ZZ24Bnm9SJqyPJ25iCNWwH9rkH419uPrMBLrfsIu0HFdlFiaKr7xJ2QjeqAI/cZRj
	 4kuSzyFYGm+xf6iI+Z1YAjlTQod6fPk7b55fV7WxjcDLbH3ATn6U9VP+rlIpwgg+wd8qN
	 rXcqn9TB7jKsStLc52G2elQKec9t9OMFi+VdP+aQj6M9H6ponDnWu9cIx5oH1bTSG2uXU
	 WTAXAVaH/SH3PtEPd02+igh+VxfwQWY2SiAq6QzlhHTc2dUnf/2vZKxpseM3yTxLrwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319709;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=yW2w9HliReqTx/Z8SxheEwwGbq76kz+2E5qJlNgL3xI=;
	b=SgHA4QtJqHGECB8Xi6USHxYNbh0uDyGiqJeuRcwounY3Xle7uCn7H9KCVbEVqKT8H8Z2
	 93cWB/1oeEM4ec0YgC/xayLGGM+7qA5g1caUzsGaWzNNhsp6rbYjgFKZj0cOgtiEAZ+dl
	 pzghuCtH2BrfkH6Gb2uPnVe64BZmuUpiYjIJw6VgfE8/WZfMHrsZnHp6LmVJ1LGlcHVdf
	 A/sP4h4vixCgAapF0MBf278pmKtVa5K/4xfBrrh7/67as9l6GfrtTfDIM3IowsSNDtmqA
	 7TGrzMOtCqT1MbkC1ZxHGqzjuqycd1JI84JrJRHscx8GMKtyp31mDREK97UGKPBJJeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMoq4m5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D160A2628
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMoq4m5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F651F008A1;
	Tue, 10 Nov 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319709;
	bh=yW2w9HliReqTx/Z8SxheEwwGbq76kz+2E5qJlNgL3xI=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=lMoq4m5wz8Gic3BTVND1BWZFGJxbbP9l1GkENhdE+ChEJj4KN7v/6VpwAmLC9IPh7
	 y9VtiCTdSnc+1KcpywDdU1dyMiAodUX/atT4USu+doujROi1AfIhCrMM6Gq+WQtqaT
	 XLL2GL8NfMDxWkOnrFLVBPhMhm4FdmLMiSbAeU29kNDeWQfydls0zIZyjiVhsfbaBg
	 VmCZR6qGFjGVpHiISJquQ4cLcidnf8sPBV/hsS0V16sx3QOeQwF6ygUe5zM06xKzSO
	 LYcDKGqZohYW+sz+BampmFQ91Vz1VnlfD7gj3cAa7W1gAKlmgdPsBebHK5aoRQZRqI
	 vIsCwe/92RRfQ==
Date: Tue, 10 Nov 2026 15:08:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: Avoid postponing periodic data writeback
 indefinitely
Message-ID: <20261110-replizieren-drehmoment-sukzessiv-800c7a61bfdf@brauner>
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
 <20261029015217.840177-1-hongyu.jin@unisoc.com>
 <CAMQnb4MVyDMnS039hE1A=2jp6y2WF1zQFw1DfDzeEYsT0tKk3g@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMQnb4MVyDMnS039hE1A=2jp6y2WF1zQFw1DfDzeEYsT0tKk3g@mail.gmail.com>

On Fri, Nov 06, 2026 at 01:50:49PM +0800, Hongyu Jin wrote:
> Hongyu Jin <hongyu.jin.cn@gmail.com> 于2026年10月29日周四 09:52写道：
> >
> > From: Jan Kara <jack@suse.cz>
> >
> > f2fs periodically calls sync_inode_metadata() for some inodes. The logic
> > in writeback_single_inode() thus periodically calls to redirty_tail() and
> > the inode's dirtied_when timestamp never gets old enough for the inode
> > to be eligible for periodic data writeback. Thus dirty data from it is
> > only ever written on explicit request (fsync(2), sync(2), unmount) or
> > on dirty limit pressure.
> >
> > The redirty_tail() logic in writeback_single_inode() actually should not
> > be necessary. Since this function is used only for once-off writeback,
> > there's no need for any livelock protection among inodes and
> > writeback_single_inode() is only responsible for demoting inode to "less
> > dirty" list based on dirty bits cleared as a result of writeback. So
> > remove the redirty_tail() logic and add a comment explaining the rules.
> >
> > The redirty_tail() did hide a race though, the one fixed by
> > commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
> > __writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
> > is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
> > write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
> > with only I_DIRTY_TIME), the dirty pages come from a racing writer,
> > whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
> > queue the inode, leaving it on b_dirty_time or b_attached. Call
> > __mark_inode_dirty() in that case instead, so that the inode gets queued
> > on b_dirty.
> >
> > Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> > Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> > Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > [hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
> >  dirtied while it had no I_DIRTY bits, update comments]
> > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

Jan, you're good with this fix?
