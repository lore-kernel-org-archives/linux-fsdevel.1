Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAA72B9A4;
	Mon,  3 Aug 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737353; cv=none; b=YOLrJoxnD/pvZADA7U/8INmGzWAx83FU8+DFRVu50Suykdacyq7avjXTfWypwxI6VxIMdYX+aZEXYeOw9rEwtoLcHevYNT1LCYUIXkMx2KZK2ThkReTqe+pm24GoqNqyIeAcOev+NOqbXbs5bbodBITXk2t+58E3J0Al+SpsPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737353; c=relaxed/simple;
	bh=J7z7JoGoPCG/YjbaHA84IGLx9f3C+5MbX0r74j9b9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9rz2rx9vbI+wT9rIya4r69GCsBm7xUMWzYjbtvkdbMsv0DTY2443TZq6MPyseTrClKIW+NuzRCXhdK3Sby0m9LLmqiFmYG1yneURGVH9PmbAWq2TOOFIzxw0v+Ph/Klt/XuhDcVDldfTQK+UzSeDlGEyjyAozmdfEV/zkNkrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sl+fV5Ni; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sl+fV5Ni"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600C9143D;
	Sun,  2 Aug 2026 23:09:05 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658FB3F66F;
	Sun,  2 Aug 2026 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785737349; bh=J7z7JoGoPCG/YjbaHA84IGLx9f3C+5MbX0r74j9b9l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sl+fV5NiagYIYA3Q3MMbV50Ng3fzo/fxEyJInTdFLqNtIW1Of9EAsrjd3JCDPj1Jr
	 iMvnKoCDzhAnU8sYVYTmXHxCQTrNn/+FcawPFwoFXUPeJPUsN7nqnpo8TjBFKHbGv5
	 1rfm+d/Q5edMvpcqWGw840RLPmIWtse4x+pjKj4M=
Date: Mon, 3 Aug 2026 07:08:48 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	elif.topuz@arm.com, lukasz.luba@arm.com, philip.radford@arm.com,
	brauner@kernel.org, souvik.chakravarty@arm.com, david@kernel.org,
	subrahmanya.lingappa@oss.qualcomm.com, leitao@kernel.org,
	kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v6 06/22] firmware: arm_scmi: Add basic Telemetry support
Message-ID: <anAwYUGTxKSyPvtN@pluto>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
 <20260724144430.1440170-7-cristian.marussi@arm.com>
 <20260728022759.5c485c1c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728022759.5c485c1c@jic23-huawei>

On Tue, Jul 28, 2026 at 02:27:59AM +0100, Jonathan Cameron wrote:
> On Fri, 24 Jul 2026 15:44:14 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 

Hi Jonathan,

thanks for you reviews !

I have ONLY addressed some of these in my last V7 yesterday, where I
aimed at completing the ABI feature wise, BUT I will take care of the
remaining outstanding issues next...just to say I am not blindly
ignoring... :D

Thanks,
Cristian
