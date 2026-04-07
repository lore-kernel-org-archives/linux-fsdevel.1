Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2E3A8746;
	Tue,  7 Apr 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557920; cv=none; b=vE/JjPVwqTZWr2hUC7O8BvF9wZwG/hk5v7m1i5vObacFhEVBCvK+ABjMPZeO4Ec2JDOYISQvCwqiC9LX3ByFQ+WB/1gUo+A41N85ciuxyfPa106aoaDdO/+bTembhwIm5b/itb58QcNNkaZ+HizNt+kzECu6FpJMFdufs8RZsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557920; c=relaxed/simple;
	bh=Wd4GSzivIg9NYgVmzRVKdaPXTLVnkGYNqbQTYvfwgDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6q+376l9Hw2dv+NEgfUK0e+b2Hd5YqW5qNUNnBzeMcrS8A/vBcfItjf7aAYG1bWcOsZdBG6I2ZTtvm3zRt2MyStV3empGq4pqUY5YfxLcs7O7TDFN9HgM1OXZTuoke7Am5TZO3rZiVeXm2lczY8wkT5nEVtmftXAExhID39kBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwTwuBQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwTwuBQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4EEC116C6;
	Tue,  7 Apr 2026 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775557919;
	bh=Wd4GSzivIg9NYgVmzRVKdaPXTLVnkGYNqbQTYvfwgDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwTwuBQZRV3kCW0jnAeV86hCaolU3v1zXjw7B8yT2DivpYPrW1hOWT3XsIWdhqMKN
	 jS3DQqIisfMcB/KbWZbY2nbUGt32l1Pug+RByBoVcumOcSaJxvEJyoU3v7uV4Ezqev
	 Gyyp1tJlugwVZwYuMHZ5IxdATCMlJ/R3eE9yAVeuzwhEgFXJgdHM6fHn97IyJbIIFy
	 oY/YqLge7BQmHl2aeRhu2di+bagSyTAmXNiwYVWCKqWpiyRCOqJsIp8kszhgE9Wao9
	 yG2+m6XZon6Q4wNW2m7LLOLHnL9YNdU2EKyS0ZntkljYlq9gcAahJYtlLFjjSp41cC
	 NQaQh2hRw5N3A==
Date: Tue, 7 Apr 2026 12:31:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Aleksa Sarai <aleksa@amutable.com>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: openat2: migrate to kselftests harness
Message-ID: <20260407-eskapaden-neuplanung-16ec00fcae1b@brauner>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
 <20260331-irrgarten-decken-b589936aed85@brauner>
 <2026-03-31-somber-private-crew-movie-exaY9q@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-03-31-somber-private-crew-movie-exaY9q@cyphar.com>

On Wed, Apr 01, 2026 at 02:10:16AM +1100, Aleksa Sarai wrote:
> On 2026-03-31, Christian Brauner <brauner@kernel.org> wrote:
> > On Wed, Apr 01, 2026 at 12:43:30AM +1100, Aleksa Sarai wrote:
> > > These tests were written in the early days of selftests' TAP support,
> > > the more modern kselftest harness is much easier to follow and maintain.
> > > The actual contents of the tests are unchanged by this change.
> > > 
> > > Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
> > > ---
> > 
> > Looks all good to me. Do you want to maybe migrate the tests to the
> > filesystems/ subfolder as well?
> 
> Good point, I'll move it over in v2.

Thank you!
