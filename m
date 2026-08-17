Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428643E08D;
	Mon, 17 Aug 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974288; cv=none; b=U9c8CbQS9uYbzvpjeG9V0fnaiBc0S2wHON16ceSttS1sLjYssCuVe1A/kf2vUwGRDdeKfDBBJ+99knAEP6oq/s/Ayc9POOsPlFzxybwz04J6+UelUux52S3HV2wsvyAEqgVxN+dWVpRYc/p2gtAV0/S02hfmu09qMWT+bk6LYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974288; c=relaxed/simple;
	bh=mDHC65IAoWfSMGoIO2rZpD+8lEClkXzRr5mbi6JecYA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QxStpUQRbRj5T420bo7OLj4db40NdYZ72aUYq8tov9mWo/WkrmWZeo0nUet6Th2HEV5DfuqkLc64+mML00xvEa5zBI6yspviU6d/2pmK0R+yteJ0hdkGH1kwZQDF5ly460Oojh8EO7kM4+BojmBfH7m9yFJDcwj/RDvNu2vqxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Vzn4R5BO; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Vzn4R5BO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786974268;
	bh=W+JMMRGB4tIrHKBKBuop5+/Mj3FgWMwZrxRtqWLRuC8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vzn4R5BOzaninZ/+mLrqCepFUMxd3r0Rrl4vOpuFbjcPOYgpjX5+zJLUB0e7WhUpY
	 1Yfzv1rGV03mkgrZUnlrJpb/il5Pe7nFzDwxARc6DkfF5VOVzzqZ228IvSVO8RU4/2
	 Oh+Nwvr9Wvivnbd1TFGvUTnWWxizhNnikPzyCbEw=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hNvFm1PnBz6vKy;
	Mon, 17 Aug 2026 13:44:28 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hNvFl5Krsz4y6W;
	Mon, 17 Aug 2026 13:44:27 +0000 (UTC)
Date: Mon, 17 Aug 2026 14:44:29 +0100
From: Bradley Morgan <include@grrlz.net>
To: Joel Granados <joel.granados@kernel.org>
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/4=5D_sysctl=3A_Disallow_part?=
 =?US-ASCII?Q?ial_updates_for_erroneous_sysctl_vectors?=
In-Reply-To: <cwfpl5h47km6f35m5k7wa2pj3elciaax6i3nmetxcgws66qewq@fzygztolxed4>
References: <20260814-lklm-partial_ctlvec-v2-3-9df50d26e477@kernel.org> <3A4FCA2B-2F42-4E8F-A328-5C1BD658B2A8@grrlz.net> <cwfpl5h47km6f35m5k7wa2pj3elciaax6i3nmetxcgws66qewq@fzygztolxed4>
Message-ID: <FB1BAD61-3BC2-4CF0-9345-6CC2E9EC548A@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 August 2026 14:43:44 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>On Sat, Aug 15, 2026 at 05:05:26PM +0100, Bradley Morgan wrote:
>> commit_conv_vec() writes the elements one by one, so a reader can
>> still see a mix of old and new values while the loop runs. Same as
>> before this series, so no regression, but the changelog could say
>> this doesn't make the write atomic either. Otherwise someone later
>> will expect the vector to change all at once.
>
>Seems reasonable: here is what I added to the commit message:
>
>
>"
>... This (The staging vector) does **not** make the write atomic as a
>reader
>can still see a partially updated vector.
>

Good enough.


>...
>"
>
>Best
>
>Joel
>
>> 
>> The copy is limited by table->maxlen and only vectors pay for it.
>> 
>> Fine by me.
>> 
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> Thanks!
>

Thanks!
