Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238B1A0BF3;
	Tue, 30 Jun 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829023; cv=none; b=YyVR8nt67wPU3HztEpFg04Zdnbq9IjNTe0kJOBqFjJ/m2xJR5dmId1TweTarIS7GFEPt24N7ZhJm7WHViRw2KhS0/g+RNAPS1+PqUCpxkdkrPhd3UNDvA2EIIwZcVcT/2okbj2B5rtmYZt0RT+Vyk4L/PmmQMRX40LY7ULoMAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829023; c=relaxed/simple;
	bh=ZGQfzpYt2YhIwe7v+7wfMdBXIFcnDDnaDTtgO6fkcmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNF8TmcIyhIogUYmCMVcYpTQp0lp4Wuoh4RSmERX1CwBFRIgUrFaA94wZLM30HpRdX+5k3wqLkC1V1cPP+qsoD8BMLEsbvhopNya0ubz2uWGw1f48WXzoq2p4wxZ7xw4blahS1ciDZXl00CPvVtPw18ubF4j3dP37P7uEYw70F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNoNpynb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNoNpynb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB831F000E9;
	Tue, 30 Jun 2026 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829022;
	bh=OrryefzzWlDGUbQu3WPT9xvectgqeQ8dLjRQaVeZG94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nNoNpynbXbYCgClLn48fWff7gcLhhu4NgGd08gG1gxpoT7mtlBWwgSD/8falcRKVq
	 fnUjDMJHb+VHZQspo1bklW1k9h+ETN5UfPc1iGWIsvh/NSAnUO38WxXVIU0wk+q0EY
	 nc/koSKYyTts1CKem8i3cOhxmtMElrE47iH6S40n4nlBHxM4Nh1RNqAaC2URRaBZQO
	 0BhD/VwhxAiWVDGKWYvA5qrnBE1Zakha8mAaJREHRh+oIOtAELMoCcQIZhVvgKi/xG
	 PR881jCiAlQbepNHwDt9SF9zXM8ThqUCtfAy7WmLQUMzuCEz++3+/Arvtdr/t5FIiL
	 Z1dmvCbP7OH0A==
Date: Tue, 30 Jun 2026 07:17:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Message-ID: <20260630071701.6b583d1e@kernel.org>
In-Reply-To: <20260629194327.2270798-6-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
	<20260629194327.2270798-6-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> The test uses the following Smack labels:
> 
>    "Sender"   - label for the sending process
>    "Receiver" - label for the receiving process
>    "SecretX"   - labels for the files being passed

Not sure this test belongs in net/
99.9% of people running this test do not use Smack.
At the very least you need to use XFAIL instead of SKIP
we use skip for problems with the env which are fixable,
like a command missing.
