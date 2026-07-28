Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E7F507;
	Tue, 28 Jul 2026 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197136; cv=none; b=iY+P3+isXG0yzFjtCyw5hsBqgYnbriBaKG3f1wDIy/M34b1gdFOMqbYQAB+Ala0Lqt2ov2qjS33VUKkN1WOqHHVhuq98F2/n/IOp+EfJjcUo84hNdqeqB7k7r5ASn8flMt9Vic1HCPSPoz2UmgM8T033y5Iff076u1tN45Sp/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197136; c=relaxed/simple;
	bh=ur6KrfP1uq9GW8a6lKTXyzvUlOB/SIaG6IF/hmPvzHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMM1XSt4Fxll8e1twK10clCW62vIHs4lOn9vokSTtaitqnY+LjJWp+w/caMBv5yBEfj72WoyfUxdlSe20eRAyI5kIPh3HQlXW77HABve/lGKnrISSl0V1W2mF5iYHJ7eHDe1cO+v9+TGV2Em350vPUIN4X+CHK2YKHsrNgN79q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkKN2I6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkKN2I6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E3B1F000E9;
	Tue, 28 Jul 2026 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197135;
	bh=ZfDn9fEtfbgd/pb7eTpc1EfqTer+j8fqHQ23wDO8qsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WkKN2I6hEcZnE3J8fZikL0lqNc1BCEn9Ui/Zk/2UBj69QG7+lg+dCFrbx+o/S+7PV
	 Rx7M+uYoCfiCclRP4JECaTQfp84zJC4KXNIM1QUpVwxmYwLEevXqSFiKYGWHL9i2Z0
	 8rgguy6JZeta+i71JZHOl6v04U91vMAeRe2nmzEjZuvUfLbOtDtff/u2sT51/W8eur
	 Z7A3XC3LLVsxNOCJZFsZnFOeMau0MvM8JNyhQF+322XuTN/z1KGXqE6svLKoH/NTVY
	 H7F3KDSZEnLe/rO5bh64NWvrbh5zKUim8tXBZL1MGixoPUjfR3iq7i2Ia5/5UdLknj
	 E6IrACJOzNMBA==
Date: Tue, 28 Jul 2026 01:05:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
 james.quinlan@broadcom.com, f.fainelli@gmail.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, d-gole@ti.com, elif.topuz@arm.com,
 lukasz.luba@arm.com, philip.radford@arm.com, brauner@kernel.org,
 souvik.chakravarty@arm.com, david@kernel.org,
 subrahmanya.lingappa@oss.qualcomm.com, leitao@kernel.org, kas@kernel.org,
 puranjay@kernel.org, usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v6 05/22] include: trace: Add Telemetry trace events
Message-ID: <20260728010528.6d1ff3b2@jic23-huawei>
In-Reply-To: <20260724144430.1440170-6-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
	<20260724144430.1440170-6-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:44:13 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add custom traces to report Telemetry failed accesses and to report when DE
> values are updated internally after a notification is processed.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  include/trace/events/scmi.h | 48 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
> index 703b7bb68e44..b70b26e467b8 100644
> --- a/include/trace/events/scmi.h
> +++ b/include/trace/events/scmi.h

> +
> +TRACE_EVENT(scmi_tlm_collect,
> +	TP_PROTO(u64 ts, u64 de_id, u64 value, unsigned char *tag),
> +	TP_ARGS(ts, de_id, value, tag),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, ts)
> +		__field(u64, de_id)
> +		__field(u64, value)
> +		__array(char, tag, TRACE_SCMI_TLM_MAX_TAG_LEN)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ts = ts;
> +		__entry->de_id = de_id;
> +		__entry->value = value;
> +		strscpy(__entry->tag, tag, TRACE_SCMI_TLM_MAX_TAG_LEN);
> +	),
> +
> +	TP_printk("ts=%llu  de_id=0x%04llX  value=%016llu [%s]",

Why the double spaces? I was thinking this must be a local style thing but it doesn't
seem to be.

> +		  __entry->ts, __entry->de_id, __entry->value, __entry->tag)
> +);
> +
