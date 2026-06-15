Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1C1D5CC6;
	Mon, 15 Jun 2026 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509734; cv=none; b=Ro7IF03HChwO9VramKHHS6t2nhgoWgd0jeaO2BlRQc9oYQVDGna16qAKHc0DGy5atj2HFWb1ao+/t91G3Vz9eVahBddLKrWR4M4k/RMqu0DQDtE3+jo+J4Lhh+ihvyQemphafTM+AvRj9H93ghefHnoKCcKy4fQ+U6Flwyoijf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509734; c=relaxed/simple;
	bh=130tyfKNAu8zFNvpSe774fd5eUuTFedAwCdY4KRvrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7OWIdRqRmZ4pvcs5yIxMhZyrNSrnOatMscfHo7iul53R80QxzbCQSYLBCUbAxEg16M7xJFArsdt5tg7IUkzYsBSa3YH5M5CwP+/5vE+J8mzerRYBcqDQM2re1q7+Gdn/xfZe+r9tkngUU30C4q1xhH1xUzFGzq66cbfIWGbFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kyiydL8a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kyiydL8a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A648B1BB0;
	Mon, 15 Jun 2026 00:48:47 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8FB3F915;
	Mon, 15 Jun 2026 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781509732; bh=130tyfKNAu8zFNvpSe774fd5eUuTFedAwCdY4KRvrSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyiydL8atDQFxvv44Y2T47BtPwkChp6i8KbAY2qG3IiXhk81dgtB+wRbDrRfONhLs
	 3DZ+wt7i+EIKKU+wNfEzriO1S+/acmyKG8r4OfnRoWfqMxSxMQHaNUs6Id9cvTKEbC
	 y2qZs4mvkZEN4l81i7dTAzMS42Ud3bVtt/+bKfkg=
Date: Mon, 15 Jun 2026 08:48:35 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, d-gole@ti.com,
	jonathan.cameron@huawei.com, elif.topuz@arm.com,
	lukasz.luba@arm.com, philip.radford@arm.com, brauner@kernel.org,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 02/24] firmware: arm_scmi: Reduce the scope of
 protocols mutex
Message-ID: <ai-uQZasZR_MCgSn@pluto>
References: <20260329163337.637393-3-cristian.marussi@arm.com>
 <20260612101525.340337-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612101525.340337-1-usama.arif@linux.dev>

On Fri, Jun 12, 2026 at 03:15:24AM -0700, Usama Arif wrote:
> On Sun, 29 Mar 2026 17:33:13 +0100 Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Currently the mutex dedicated to the protection of the list of registered
> > protocols is held during all the protocol initialization phase.
> > 
> > Such a wide locking region is not needed and causes problem when trying to
> > initialize notifications from within a protocol initialization routine.
> > 
> > Reduce the scope of the protocol mutex.
> 
> I think this changes more than the mutex scope. scmi_get_protocol_instance()
> can now drop protocols_mtx after idr_find() while scmi_protocol_release()
> can concurrently drop the final reference, remove the IDR entry, and release
> the devres group. Does that leaves a use-after-free window around the returned
> pi?
> 

I have to review this mechanism in general in V5 so I will get back to
you on this once I have refreshed my memory on this own code of mine :P

Thanks,
Cristian
