Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0D1A6826
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794231; cv=none; b=rruTqy7nG5dcPQhuRb7zcSJQpjHBuFrunoIBzk4kiQelFfrN+Jg2AImNzJh3T7IFcZNJzdZDUvdD8LcVNCwBIOOvlV3uxHy/vqY5YoyxneANIF+amU0lRnTwlORxgRPAgqXT7RPgIsVaJMAlKKF06xKU0qh+HlAyOiO4xkT+BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794231; c=relaxed/simple;
	bh=OEK5oW4wLs1u0THt1SQL1haVT0trGEwkdGbNeD9aXgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAJr3PgH67MjSXFvMhR7V6s7CCZX1GEDXYLV3jHR4GQBnmCW2bnPjbZl1GHR00ivLA1+Y7EmzdW8INOrX2MRlePb5KoNX4eujx8moaSFzQP+xuVpLheZaXYkb16JnfdVTRpyccwBEpiw9752DjiR7PPDgNyk7gInm5SUzhBq6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=peTitjPK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="peTitjPK"
Date: Wed, 18 Mar 2026 00:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773794228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHCN6mcqaZSdd5vxvzhBtyvx5QgoZE0QetGGERuLo8g=;
	b=peTitjPKXGshQnZgcfPGqzsTKszjeUIb++MQYjH9VDzjLWxUSTAJmExCdslxQtfrxGR2I/
	SkxZUIc5mDzj99BUD8HMTfhx4f9PhHoIBhIMo5IUvY7TH+AkCdyIlIQ0qIhwjMYG/3vJtd
	n0feoK3KFKWsTyiehB1I0jDXNY7XTVHDL1PhSks+TcFDbdacgE/J3DOXAsTvv43Z/UdMXm
	n2poak7mXORBgLSdF18HJArG3ekKK4C/1wTcaV3rtfEeIJPT57v5xl5UGxG3gPToHtFV/n
	D9Mc/hj0Vqfd5pJ0s28D4ca4vkpVaniKh+rO5OGHrzxSUZs/UwefCDQ8OwsLIA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <abnzsVk9JNN3alKq@Bertha>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

Sorry I struggled to understand you here Slava, there's a little bit lost in
translation I think.

On Mon, Mar 16, 2026 at 09:50:14PM +0000, Viacheslav Dubeyko wrote:
> by hfs_cat_find_brec(). But I cannot imagine that this logic can extract the
> record  with incorrect CNID. Because, it is the main goal of hfs_cat_find_brec()
> logic to extract the record that contains requested CNID. And if we requested

Do you mean that you do not think hfs_cat_find_brec *can* return a
record with incorrect CNID, or that you do not think it *should*?

I think Tetsuo is right that hfs_cat_find_brec() will return a catalog
record with different CNID in case of a malformed thread record.

On Mon, Mar 16, 2026 at 09:50:14PM +0000, Viacheslav Dubeyko wrote:
> logic to extract the record that contains requested CNID. And if we requested
> the HFS_ROOT_CNID, then this logic should return the record with exactly
> requested CNID or return the error code if such record has not been found.

Do you mean that hfs_cat_find_brec() should validate the CNID of the
catalog record found by hfs_brec_find()? I'm worried that validating
every B-tree lookup is going to be expensive. We could do it, however.

Thanks,

George
