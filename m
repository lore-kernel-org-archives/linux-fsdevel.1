Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206726F2BE;
	Mon,  3 Aug 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737871; cv=none; b=niAIWYBTAKQASe0JG1ZiZN/zn94wloflixzrIIsKR4fbiLFEeaM9b1iQCBw9ANarAjMPryn5hzaW4EntI5TE0rMcA3By0Q3PVpkR+2hi6yR+WjTvzWEyhYkpaX5gpTS5lvAFWhOC/ZNF+Bi5M+1Vun96TijfYLrLAcRDfHenszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737871; c=relaxed/simple;
	bh=CQ3FXkdxeKWpPhELkqzv7K35M4eBOFi0oyoT0bpmWbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjmgtgAQWTRkvCfqit2r6tehNrFBl4hh68hankf6t21K6NF0fcfwYG8VpWWh3V3RbTfcf7ti9Qodcq5d1UOan1OG/zgPb8j2VUhqWBoIfrzhextLea3aXx6jVZInWwYGHInVfg6Xujn2Cadw8CgEP7EwrriKoi5SgR/0oPSSQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GR7C01Rp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GR7C01Rp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 359C6143D;
	Sun,  2 Aug 2026 23:17:45 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A88E3F66F;
	Sun,  2 Aug 2026 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785737869; bh=CQ3FXkdxeKWpPhELkqzv7K35M4eBOFi0oyoT0bpmWbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GR7C01RpF8anclulhv3lLdm+7g/UgSg5w56GRavq+rJ3vzytJVeGOQX3l1ViAxpkW
	 8TCVCQn79y931nRk4K9w1IzCFgIYkI4kUaHR0y4KMrr8fIWLiKrejS4NpQuGec9DOp
	 ss1cYF/ScRq4fYco1qNBoJA7lj86cgD196NfSXXQ=
Date: Mon, 3 Aug 2026 07:17:39 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Fayssal Benmlih <Fayssal.Benmlih@arm.com>
Cc: Cristian Marussi <Cristian.Marussi@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"d-gole@ti.com" <d-gole@ti.com>,
	"david@kernel.org" <david@kernel.org>,
	Elif Topuz <Elif.Topuz@arm.com>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"leitao@kernel.org" <leitao@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lukasz Luba <Lukasz.Luba@arm.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
	Philip Radford <Philip.Radford@arm.com>,
	"puranjay@kernel.org" <puranjay@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	"subrahmanya.lingappa@oss.qualcomm.com" <subrahmanya.lingappa@oss.qualcomm.com>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>,
	"usama.arif@linux.dev" <usama.arif@linux.dev>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 00/22] Introduce SCMI Telemetry support
Message-ID: <anAyg0hr3S6mfIYX@pluto>
References: <DB9PR08MB86510C934D2EF25F625A5F38FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR08MB86510C934D2EF25F625A5F38FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>

On Mon, Jul 27, 2026 at 02:53:45PM +0100, Fayssal Benmlih wrote:
> Hi Cristian,

Hi Fayçal,

just a quick one to say that the latest v7 just revolved around making
ABI feature complete, so closing most of my pending TODO list...I have
NOT addressed, if NOT minimally, these outstading issues or most of
Sashiko reports....I will take care of all of these starting v8
tomorrow..

Thanks,
Cristian
