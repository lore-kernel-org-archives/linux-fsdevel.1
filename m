Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916762;
	b=YCTcSPIdHjSTIxeJ31Duw6acSXKppG9Z5nk0avLjMFfS4JPkBYGb6SJ9h31xl19grWMd
	 T6W9RyNx4HL5HnOFi9vvWllAN0LjrOdQvL+tTrQ4FaJC9EO7W6pNMCSGEThrR8BvsAmw8
	 nCnFaWMi8f064WjCEdwgQFs8wzwMUqsiUSSIc1d8WuHC/2creeVs3ZfHTtBm6OyQriMBW
	 mtbIRZ89vED0ytl1m0m6uTKAJ7bEn4Hp4fPL/f3wIpg8r6+J7vyFpLXnF8rjffhAPxZAX
	 UnJO5vLqCJerxJJMcjCcoDvyrvag8N//mqzynzYKUXZ/lOeALB5BhQx+//e/4iod4pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916762;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F2l1OS/+Jc/lZO07nQMOSgWNuzoUmMBtUBpenkKLMAg=;
	b=fPuKTTbwh9XL/n9rAwNlBJYewreWbO9uxU1Cdh1o30lwgToNbuFioWucGaruF5XlVRtJ
	 jcQkY1/JyS/f9IO9F8LTbYUoI6K0Tl9ORlKTfnQ7tq+TqOni1+MuP+0Ivtv2Q2dJkSc5h
	 qPFTe+gqjy8Dir2HXzKgqPWptDDVQ9BSrlzsypsTgFjmO9la05h5OtZGsKxAMAR8LSnIz
	 6BdvIo4OZ1HfUUo93GELNQevxpZsPWptl08J87Fyxkj/luwvq+1I4LHXDclnwjr4JKUrF
	 EIC1IwzOZWJqX7gvS5DrsDO1+KjikqWGK+WoNJKbh7bSDaC0U1LG+4xPLmiEsD6Idkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKJ7dYxE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740C606A31B;
	Thu,  5 Nov 2026 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKJ7dYxE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C27E1F0089F;
	Thu,  5 Nov 2026 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916762;
	bh=F2l1OS/+Jc/lZO07nQMOSgWNuzoUmMBtUBpenkKLMAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QKJ7dYxEPEcXOaSH+0dWeFEClZoZgNvXMTnbKDO+Hl9kxvd+bAaAunRa4rXjD6gc7
	 LTzsvA147NdZUEPSDx9a+r7OIberNqMw0TC9S4Nk83Dov6huRIyd7dyRsUYqQjR5v3
	 BgI6hn3iEOBBxKLj1ZqrpGj75kDzJDduZ7I2tYaxKvlj6KhWhIi41hU5Wp/cU1r0Lg
	 LjYbZpyzfCemRdyK0NqNRLkPvx545B+4YSsYLbX3Wu38GwcVC5qIE2bRyLXn2TJivv
	 TTHe3IhFWR625F3TGeZIQmB+LWvgFUjTby1WipsQ4yaHn9KEKxVF5KlSW5PdrXxfgQ
	 8CHLTeoh/5Uxw==
Date: Thu, 5 Nov 2026 23:12:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/namespaces: initialize the byte the children
 write
Message-ID: <20261105-burggraben-wegrand-seeufer-18d3c8517fef@brauner>
References: <20261103165419.687806-1-sashal@kernel.org>
 <20261103165419.687806-4-sashal@kernel.org>
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
In-Reply-To: <20261103165419.687806-4-sashal@kernel.org>

On Tue, Nov 03, 2026 at 11:54:17AM -0500, Sasha Levin wrote:
> Found with clang 21. The namespaces tests aren't in TARGETS in
> tools/testing/selftests/Makefile, so CI doesn't build or run them. Is
> that on purpose?

That's an accident. Please send a patch adding it. Thanks for spotting it.
