Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042443C4B84
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444670; cv=none; b=JV+uIRccoKJc6WriLMqe3y+KgARPnvNVufsBUdjvWfsxQFXL5YqiRm//ORjpxZDpnh8fDvVFz+rAuYco+wdqtOd54rXtcrY8XNE7n/T/gvT557NPsUe4Ei5M8RZBbYim3w87ADWKFo+leOolJvsUE4AMV7du0ZkIegnyh1XYXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444670; c=relaxed/simple;
	bh=uyPwp9wIlF1sm4uOpT935qhJmj2N5Ft/PLgAl5AR19o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzeRim658e/f1FGOttIhwL/FwrkYOEko9LA36lBh5jBM8w5UM9aICx7CDK6LlcGbLK5a6c24JztjeFRvOl1f12QiHemgUvCP0SpGZNo3PAK/W648+SivOyOkVcmyaSDPcT/wYz+JP2oVCwHf0YOGEQ581nG73ASdW+unWY8sEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKAb3vzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKAb3vzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2C1F000E9;
	Fri, 22 May 2026 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779444669;
	bh=K6z8ytLmY7+zCQKWRdYVqAzNYEpmKKdacF+F3I+3rpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKAb3vzQZpaGQplNDU6423lEk0EP3+7N4wDDhicTCvp5xHqSb8BXRdb4solJMV+9w
	 XrNXln11AvW+mV1ycggrylqce0/GqWDKHnc3aJRSP89C16ZDTWOcVanHcLTzG1GzEY
	 FhiLsqET3kICQ8r492dfTWWwkfX+Pfxlo1PeLsCgT6rVV2vhbFZzntT/eiPMRBVDAk
	 4/R89BtnSlbIYAxqHoVy+yYzwOahOI7Pw4bQvPcj9OGOfr+PBOUqg4RImnebLaIOts
	 jvCw4DnayUzXEBbXZIZ3S0DFT9OFc0RsWu64rKSWLV4nEyY28rx47CdvJl7dV2Dgkh
	 G3+G3imDapmSQ==
Date: Fri, 22 May 2026 12:11:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests: openat2: port emptypath_test to kselftest
 harness
Message-ID: <20260522-reorganisation-altstadt-nehmen-e1c1d17cd445@brauner>
References: <20260521-wettstreit-meinen-46271dede480@brauner>
 <1947081210.2128972.1779371780097@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1947081210.2128972.1779371780097@kpc.webmail.kpnmail.nl>

On Thu, May 21, 2026 at 03:56:20PM +0200, Jori Koolstra wrote:
> Hi Christian,
> 
> Sorry I didn't yet get to this. Had a busy "my actual job" week and was also

Sorry, I honestly forgot that I asked you to do this. :)
I just did it because I was assembling vfs-7.2.openat2.
