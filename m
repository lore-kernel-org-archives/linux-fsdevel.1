Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E043F823C;
	Mon, 27 Jul 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195704; cv=none; b=m1JAI6bRV3ZWGCUrQkvE9M7fyJ3xOUnLR8BemP1PX+sKq6tuiqpIvnvY3rX6HDzKpOUjp0duZETZuk6aWlzmjnOoPAcI5oKyGcjFsLAYgqg6FTvRnI3NS2cKCUQPrCjlhNF5SLincsWmVsLYanxmyThEBEP7sGoAYRyQqrghk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195704; c=relaxed/simple;
	bh=dBwpkf0Ae54sj2tg7PXH7EHOtQlUomSxc/lp+N26aeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtIb6PoUgstZfqYY9a7ZDSoVNyCsdytRutnw6jOalrdsolNYNzsNJLrcwS1gx1V5pPZj84HE47e1CiSAPEHTsDS6bFnIiYox6WbOgw09rcWlAXyU5W28W6P2lVBkymhelBzTxtxGmPyF35ch5H9ppyn6oVZOVzuHA3DS6yh0G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPJVrHMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPJVrHMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054601F00A3A;
	Mon, 27 Jul 2026 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195702;
	bh=X2ZTkpUJeXP3YlXl7No/41qQLjvNAIvVjUVPINNflsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PPJVrHMqNES0sq6q2+DyQSmwNyJdZ50Wr7yAtRGtvNhQEuoatMLw4j2wAH+nXbUiH
	 8pJAQ5kT/F3t7lzVA6tiJgDVGiuvTDijX/IaW83P3HQBmG7W7xDj8Tlj2EenA7qPlD
	 gNHTUMNPBEA21ewIcOhEawb5CVYXkC5AFH61MFqlK33Rxw3iQZQDmDiAinFJf7doSr
	 U09ZeWaMWPRydWAECOLCyIClWNEokZU3Iwy6sgMBZpsEQF8+7RuY8UcYTX7EM+OHtt
	 vTmv8XhYF+/fJ/mbEd3cxbBgqsL04Buv3YYXz+uKCmOcAgqcySUjrksDJWNfRALh31
	 9HN1mXoL59X2g==
Date: Tue, 28 Jul 2026 00:41:36 +0100
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
Subject: Re: [PATCH v6 01/22] firmware: arm_scmi: Add new SCMIv4.0 error
 codes definitions
Message-ID: <20260728004136.3e83b36c@jic23-huawei>
In-Reply-To: <20260724144430.1440170-2-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
	<20260724144430.1440170-2-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:44:09 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> SCMIv4.0 introduces a couple of new possible protocol error codes: add
> the needed definitions and mappings to Linux error values.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
FWIW matches the spec and the mapping to Linux error codes seems
sensible to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
