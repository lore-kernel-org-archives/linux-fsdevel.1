Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67753361DA8;
	Wed,  1 Apr 2026 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077281; cv=none; b=Ayv4VQU3afBItGd9GWl45Y/9u9NoKGae3wh/h+1nMnoVNdTupLOxu6RSyZI6oGdQ6+kanOSFK2muqRziE1i4Ke95ZdOB+EDMitlFA8L78miomh6KknTtr81+8dCNBiJmXBRXJu3vwTC6weSuKjLBfS2y5cGNYLRUwdrkVWQE038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077281; c=relaxed/simple;
	bh=T4El3gBYaBjbUlvZDIDW0U9Vqv6zbHXL0MfujDVHKQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwAjUj0ciiGyYyPX/XJsvnObQSoDs8VScCUFDHtGKj87CRdmRJm2zFXm6JZHtJ1jNm5D6knF9vgBYVYq2ACT7lDpfKjUaQ9KKvikebgMro8j1++bEdGEwpxmERBa/MJtll7G7ZeLRbOKYTAKP+J1xkFy7cyuIRjYiRTLsOl8u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY+QqARC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY+QqARC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B824C4CEF7;
	Wed,  1 Apr 2026 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077281;
	bh=T4El3gBYaBjbUlvZDIDW0U9Vqv6zbHXL0MfujDVHKQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RY+QqARCtm6qfgaV/syME4OMUa1DSJayCrURpbrBCtGdxUczgOzAbPcetGIa7IlQG
	 y4GOZokhHcXfnv1016t6UA5seN2iWGtGdXjbzO2I5o9iSfpaOUrzsJFltOaSoa9cZx
	 z9gh5LonnFySSgvVlQhznWvz1NkW+DCr2A5fG/1+BjhBsE4gIa/Yg/0JPk3sZZojW7
	 5Oc/nUpn2S+yuDK9mbtVck94asoawabB9SA+5s8TNsuyn71PwL949i2L++wb6gxz0v
	 +Gf0s/tV2J+tEqi9K123DXtAT4BaaJivPSJSluzdRg+f2qWUTyJxqpGQgmBRMgKB8H
	 ECU1imdb9wYVA==
Date: Wed, 1 Apr 2026 14:01:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: require verified birth date for file creation
Message-ID: <20260401210118.GE2466@quark>
References: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>

On Wed, Apr 01, 2026 at 02:43:21PM +0200, Christian Brauner wrote:
> +	u16				birthdate_year;

Shouldn't this be a u32 so that we don't have to rush to update this in
the year 65535?  Maybe even an arbitrary-length integer stored in a
separate allocation, so that this won't have to be revisited.

> +		if (age < 18)

Probably should go with something a bit higher to ensure it's sufficient
for all jurisdictions.  Maybe 50?

- Eric
