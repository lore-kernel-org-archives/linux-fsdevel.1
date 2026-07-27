Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E302C15BB;
	Mon, 27 Jul 2026 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196032; cv=none; b=m/Y4oF6nlYEkbOr4dmxbQ/bxzwJgAP5OT0TpIXo1Ot7CqtRfhfnwnINa93FOnfCXGeIfZ/9J+/pK0ZETylEnLmvjG82A+KZp3jf0nyDKI5ywv3PcoRvxI6mCoLMlW4Lzu48lZ4HiYgIkK9kPkeGbYsW67Tl2WwUE/0hbYY3ZFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196032; c=relaxed/simple;
	bh=bXsnOHr7WgNSRa407OUIx5fYRELzWAR4ire+zwY6XWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnlcY0XD9S4SUdhnYvUOf41QKZ5ulT/qTeyEnEIRVjcdSGscfybR/luzj8XsnG9Jk4GN2F2I/bxlWAeyMBYlMzvqMQNcX1I13Ii69SMtTVslo+Ofc6K6y7Dmlu9QgasHFSl+HcPFtJHUFOUGU2ijNVqMNzAEy2f5qpEFpJG4VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAs/bWXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAs/bWXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0843B1F000E9;
	Mon, 27 Jul 2026 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196031;
	bh=eHZ7WDv4z83QA/bqm4EIPds2VqkRB276KZK7CvOtJzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SAs/bWXkUVfiKiKtpDUwC9CcUSI/ho+9+mmVzzthlhfvV/r84NiP2KLQGr4ZH5Fdy
	 oFwnYIMqTKHql01T3Tnb9MBmxVFPF8nOxk7uVxhPmLpuz+opfgvXOlTy+I0K5zFq+W
	 LA8dgRi5XUllaPN1JH/+0eqE3EiN00WNxMiWIDrAiInQiBtQHdEIdf8xJVBB87XHo7
	 +V3HaOQMYrhvQx0AMDUKjmbiMCG+9vKvqbl8zEfMat8mbqG4HMLD3DAB0Urh3HAoT9
	 Qs+MC1AerKksZJKJWPra7JS4RrFYD2smZB2I79bnKjTduuOoQxKxZSvSKWzCvGpNQ6
	 y52Jsq08QJDyg==
Date: Tue, 28 Jul 2026 00:47:03 +0100
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
Subject: Re: [PATCH v6 02/22] firmware: arm_scmi: Allow registration of
 unknown-size events/reports
Message-ID: <20260728004703.0696ca61@jic23-huawei>
In-Reply-To: <20260724144430.1440170-3-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
	<20260724144430.1440170-3-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:44:10 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Allow protocols to register events with build-time unknown sizes: such
> events can be declared zero-sized and let the core SCMI stack perform the
> needed safe-net boundary checks based on the configured transport size.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
