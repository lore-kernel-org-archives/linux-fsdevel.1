Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866163C7E1E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823873; cv=none; b=Mkda/oMQ7dQ5jDmWYYGc0q1Pt8hew+nx4QtVnt/0nGMk37ZmGh3rRc5O59jaNUSMv6nH6TfkzQxuVlhLN+LoKjy5kEMlPseqJVSwFtSpG/4ysYio98SmJwPmIBRX0MOY6P7KW2X0oiXRAi1jbZRMMjXQA+ip0WbLQBLpwseY3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823873; c=relaxed/simple;
	bh=pqdF6Mi38GJvQ4L9GZ6r05yf5V9/rHrY6Xj3qBGgu88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdZZ+C+Lez1BWv1Q0EYnWu90gS3pF3CllPR/U5v57DaVxAIwB+zUWOYCxS5UQKojioFgTPKvHA+zCMMqjQyo1ASTfN6KesXq6XLN0h992/tx8aJzVSKqLDrMBdcb+dkTaRaGKz+laOrwfRu3sYOY0g6hqd50ZDtnyytLK5aao0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ij98B60a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGmTaxaf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ij98B60a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGmTaxaf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAA241400281;
	Fri, 10 Apr 2026 08:24:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 10 Apr 2026 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775823870;
	 x=1775910270; bh=FpnT/+E2w62wCn8dGkzDSKmYtsZfKjHDAG+9k3eh/R0=; b=
	ij98B60auEl4M9YtYsuO8fItnz5iWPgogwc6NejGiMU8KqxlQeCF1WzGAZB2p6EH
	6vfmln15xtDKkcHzjveQePPUC2V9Fdtj0JKbN5aGkdBDWVm9kv/Fgf2PwKoEcru+
	DxIMpd7KBumaVNpmu5DXAmZplUS+UJ48pXyL2/0MoVSp6C1yK4rz3hJ38DX3hIJ0
	KrOIX7CmN7E77l83GmqYyx+/KHxbSI+Yi5VabwF9cb+aGwav+3tzaGHnU/g8+EJ8
	62q3GvkWlYTbTzbDH0OatOi0JfKenjjYygnyGme34ne8Fk3+U3mVJsbr7HguwBBE
	24kK3WNv0HBSHRUywowUoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823870; x=
	1775910270; bh=FpnT/+E2w62wCn8dGkzDSKmYtsZfKjHDAG+9k3eh/R0=; b=c
	GmTaxafpYRk7c6RNMLfEnQ4I+f4JgfyiY7VgFopo32QK/NQJXLmuBEX4y8VDP+5p
	Zw9NjzKItPhrCttSTJxGRjbWdcYqHm7jAVy1DOX4gyRcigZPHwa2CauByqeIDtvB
	463byDquSADcDVSjbWkviCANP9oSFV9JHv5hDZNBE++TyTfpBG8zrjE6JGvx9trs
	Dj4aeok2jvC7e9fGiEjV23oleuZpQHHiujp5unsIFCr73ANRMq1/h/5TonGjE7w8
	wtG7D4RAAeZAJu1+4dmKbzdLsglR2rjxa+PHiZ3SKmWbdfEfXtXBzYsBWMqNa7Lb
	gzGNLOmLthNXuA1hjvEYA==
X-ME-Sender: <xms:_uvYaeu83FV8aImCNYPIeEeeSU4yCjpw9hP7NNNX5k6v_YDmZTS8Vg>
    <xme:_uvYaXLTzMrchDggItVh2IsVdOOWcpBTJg2iRkxpV2z5Rv2VC2OmX150B0dbqHX3g
    MNStaye-lvG-fEag_ZRt5kK8GRFHa2ICcawtvYc9aWRwqerDzgz>
X-ME-Received: <xmr:_uvYaTnOCXF2TM03SAsPtvf_XszRhnFdvXQLeY9cfQsaILoSv4Z-LG03lU8gkkzZoa7o4ZPeDC0WcxLfbdcYM_yk5eUHx7aH-ts2q1UzhqPXsltsBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjefgleejueffhefhueekvdduhfetteehtdehfeejhfevudethefhtdetvdek
    keevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujh
    ifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggu
    nhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhope
    hnvggrlhesghhomhhprgdruggvvh
X-ME-Proxy: <xmx:_uvYaQJ07V5eN4O62aOOP9cgERjKLjnUqMv2SAwoyG4RQLOljW0OGw>
    <xmx:_uvYaQ4AotXe_lJeT8lUoVPCCRUy16T64GlaRrxx8O7cH-hil4QmKQ>
    <xmx:_uvYac24HkJ-jvJqhn9fSTzv3GHkfvdJhl-71eZ1bWt8kvobjvLbYg>
    <xmx:_uvYaedTIfKfx7I1aKVuxtdmfDFV2RbMGD_bWLqhdbGAtA-LUD2uFQ>
    <xmx:_uvYaRH-6hLqP6lt4qfSgQpVmv3bn6DP3IZgv1H2sAug6wvSg7P7jvA6>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:24:29 -0400 (EDT)
Message-ID: <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
Date: Fri, 10 Apr 2026 14:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 neal@gompa.dev
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
In-Reply-To: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 4/10/26 00:24, Darrick J. Wong wrote:
> Hi Bernd,
> 
> Please pull this branch with changes for libfuse.
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.

I had already merged another patch beginning of this week that
introduced a new merge conflict in
.github/workflows/install-ubuntu-dependencies.sh

I resolved it myself now.

> 
> --D
> 
> The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
> 
> Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
> 
> are available in the Git repository at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
> 
> for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
> 
> nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)

I had quite a busy last weekend, because I got libfuse security reports.
In ordert to avoid lots of reports, I just added support for CodeChecker
+ cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
need to let AI work over the weekend to fixes for these (obviously will
need manual editing, as last weekend).
In the end not too bad and I don't think and urgent need for a new
release. Although I should probably make a new 3.18.3 version soon.

That also made me to add new checks. I actually already that github
codeql checker in place, but only realized last weekend that it didn't
generate any reports. On your PR that gives

New alerts in code changed by this pull request

Security Alerts:

    4 critical
    3 high

Other Alerts:

    4 warnings
    10 notes


Some of these, like "This switch statement should either handle more
cases, or be rewritten as an if statement." can be suppressed. With some
I probably agree


	cmd = malloc(iov.iov_len);
	if (!cmd) {
		int error = errno;
Note
Declaration hides parameter
Local variable 'error' hides a parameter of the same name.
CodeQL


The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
should give the output, but I don't see it yet.


My plan for the weekend is to address your comments in my series and
then to merge it. If still some time left, I would like to fix all the
reports in your series and merge that as well.
Then maybe next week to combine some mount code dup that comes from both
series.

Ok with you?


Thanks,
Bernd
