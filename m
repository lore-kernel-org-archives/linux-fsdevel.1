Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A323E3DAB;
	Tue, 31 Mar 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967233; cv=none; b=D/6gbFVepbRGuyXcrVZ3pN6pIzAtC3+jNTBaoOqG0JD3iCr59PqimypBHES6aaBS/b6iKqCwcQM2eKem+1zh3ZL+YpmSJ5pSfEm1GVP9EmwSs77UlLiCJx6tjQ+hO+aMHNHg0L3kN0dRhApRYbRCTViG3x2At7jxEJHrW5Y+X20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967233; c=relaxed/simple;
	bh=qwzcG3GoWsJZbNqPWl8rQHr9y/Y+SwbNrMMtu0fiYw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIyXjt+g3t5M7R+Np2TN3avk5TXSRb9tuM5HEOPMPgez6DGcUsrgkoIevIHwyVx586LY3lh9uUMKFQLeMlAqBU/pFYBWdbNNDI8JWl++zYrHXDX76re79XsHf8iFgoaCmXOD7gGsAXv33inXtc+tunuZQFJsuV7hiEtI4FOWRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq6rBICR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq6rBICR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B6BC19423;
	Tue, 31 Mar 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967233;
	bh=qwzcG3GoWsJZbNqPWl8rQHr9y/Y+SwbNrMMtu0fiYw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mq6rBICRx5xnqX+0zIovXGE8D78M0/k1GLFbfPVa+DfhJHMyahfbaKl/mjArYKGwq
	 kuD25hKF+4rdz8OR8bH8aj05tcPWFscQi8wa7OxPqghS/xlvrPWxY1rJdqRbI1uxod
	 GMo21o/tI0Qf8u5U35KRARxmkoyeRSX+dg1umIg1pFDy1j5ShJA/MB2vqZ08fLWddI
	 Q8+hdfoLrChYyocFhd7QMoImd4bZzOsORH5+p2JRLpGIsFczsaTpWTJM5Vmloyjlls
	 /ZQ78KGnA4HMG3zoAtSmszbi/XzPUpzzVNHyt+3bFjTjjAyrIegStgHTUvCraowkla
	 zYBOI01ep3Rlg==
Date: Tue, 31 Mar 2026 16:27:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <aleksa@amutable.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 0/3] selftests: openat2: migrate to kselftests harness
Message-ID: <20260331-irrgarten-decken-b589936aed85@brauner>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>

On Wed, Apr 01, 2026 at 12:43:30AM +1100, Aleksa Sarai wrote:
> These tests were written in the early days of selftests' TAP support,
> the more modern kselftest harness is much easier to follow and maintain.
> The actual contents of the tests are unchanged by this change.
> 
> Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
> ---

Looks all good to me. Do you want to maybe migrate the tests to the
filesystems/ subfolder as well?
