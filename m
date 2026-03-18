Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF663D7D90;
	Wed, 18 Mar 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839861; cv=none; b=axRP7e7jowEJJXzlEyp1Y0ekEmgMHNC0Re3yEBfpehHkPLN/qI5NNcQVJpg5wXdxGS21qDzuKhjXIK3vOu+wxfF0N/XJnXb983w2BrLFy9Ac2r4WVCMuKcNZptiUbXB9SVavCVpauNEFXvxc37pj+4z/ljmTmEHMeTk/lRx2Orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839861; c=relaxed/simple;
	bh=HtqezVCsyIr4++CWug7arCABlJEKaUiYcGBUqWOK8nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4qplAQyFqy+qQrmeMhZmHnAlXScSssgKEMcGlFYgkxNayhHFilByKb11AeVI6Dcldm5chvAzjCMiRIuws/hLpVYUuhYIUfdZ50+JmtH+lOc6uiyQXW8BkLVsvnJw1M1evZHnRmHjp62sztaulmsvDSVydHFXh0FrNgBPghHjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB6C1E7D;
	Wed, 18 Mar 2026 06:17:33 -0700 (PDT)
Received: from NH27D9T0LF (unknown [10.57.20.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9093F73B;
	Wed, 18 Mar 2026 06:17:37 -0700 (PDT)
Date: Wed, 18 Mar 2026 14:17:31 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: add core_pattern specifier for si_code
Message-ID: <abql6_yzm1E_-PKR@NH27D9T0LF>
References: <ablsdmLsMKm0z5wt@NH27D9T0LF>
 <20260318-lanze-dachwohnung-d04d1ff63e12@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-lanze-dachwohnung-d04d1ff63e12@brauner>

Hi Christian,

On 2026-03-18 10:45, Christian Brauner wrote:
> Request %F which installs pidfd for the coredumping process into the
> coredump helper then use the pidfd info ioctl in you binary with
> PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP and you can retrieve the exit
> status including the signal that was sent to the process.

Correct me if I'm wrong, but PIDFD_INFO_COREDUMP seems to be setting
coredump_signal, which is siginfo->si_signo? That information is already
available by using the %s core_pattern specifier anyways.

What I am looking for is si_code instead. Perhaps a field could be added
to struct pidfs_attr and set in fs/pidfs.c similarly to what is currently
done for si_signo?
