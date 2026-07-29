Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F453BB124
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308754; cv=none; b=Vz96ZpsE86RBalD39UKryewVeMeltK7HriSWPndANqQzlk4sEm0Ht/LV94XKyDIqWmcZdfj7GZS7Qd/DAkd0kWWqd9nyJZ/2wdWWJhw0aSXX1kVzosYCMlvvBafv6NpGtuD3ShH5CpQandZvPZr3ZzzLOHGabDkO56n8ogaHGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308754; c=relaxed/simple;
	bh=UYmxN1+Rf7F6/FDViZKIr8iYAyzN/WQXMBY+RplDcyE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cA/4K/dE1ihzNTsBfzp7ms2cT5d1A0Gn56FHIva71H5+sGdrVniLtK8D8fn+WVF4NvG6Weo+1pZEao59bFK9o5iPZmjGR8oCkLKhCwGdeDiVlYm3aEmS/ujPlmnmusZwWio7zjOWdGu5pu7O98rfhEANDlLP/+fMI73xaluVqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwzZsUtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwzZsUtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CC1F00A3E;
	Wed, 29 Jul 2026 07:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785308753;
	bh=T5yTN590XvstByPEJNNSdVFWovwty1jZefAlV9LuZFw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jwzZsUtIDmXoAWG5J/x3M/D2/F2lgXC7lfy7Xp6jla2mDLXEBuksTVwaZK8zpG0xC
	 k3oYoN0G98UpYMYp9KcFfk6OG3NE5eHv8A7Njrr+xy8fmTgPnX4QdBpuhU4fDnPCCY
	 0IsxTVW5wW8j7TpDE6lLRqDoUigSk+/6BgMJnMRpt9tXDAFvaGRh/QeyTax8bWe7o6
	 3h15/E6bVs+dU33lDOZNtprE/R4FV9Dxxzxcf9PcITJlRftsfzjt1KEiK5ZRBUzNVP
	 2hCx0GbUPDd60KTnODZVoWIKcfJPspdJ82dJjnX2urgXn2faVoCJ+tSxRpjZA6BMU6
	 bu1PgtlphB8ZA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] isofs: Drop support of directory entries straddling
 blocks
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260728160359.3939399-1-jack@suse.cz>
References: <20260728160359.3939399-1-jack@suse.cz>
Date: Wed, 29 Jul 2026 09:05:50 +0200
Message-Id: <20260729-formfrage-ergeben-tragbar-e351abd26a6e@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=502; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UYmxN1+Rf7F6/FDViZKIr8iYAyzN/WQXMBY+RplDcyE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlLgs4nWKarah9aWPPLPUix2UNr/OcA9wfmdwo+XWdb
 ava3bhzHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMR3MbI0LXv0dUtfx48j3v6
 hi/6hv/W5JqfFVPizHbHZv3zF5xa68rwv+7LDtO00O0qGq/XKOpMVD6xKOL03Dh+7vcd6T0hzk2
 aLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-28 18:03 +0200, Jan Kara wrote:
> Based on isofs standard (ECMA-119) directory entries are not allowed to
> straddle sector boundaries. Isofs images I have available seem to follow
> this. Now that we have code verifying validity of directory entries (and
> so we'd properly refuse such entries), let's just drop the code merging
> directory entries straddling sector boundaries.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

