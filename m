Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B751A6820;
	Thu, 26 Mar 2026 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531963; cv=none; b=af5VvZL17PfWfABu0yf/tTLoDabiw02IaIT4TsBatUNvw5jMS5mNLpX6fHfNWn0fhC78FWOUbXlXJvARlX83DCT28A1tKflK+c7dnF2haagh+VmBB7ETUF7FaGqjMORw0JSU69bPTw/IUgK5iL5EjMcH0C6yDpVm8kXu7QYAnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531963; c=relaxed/simple;
	bh=pVRjgvx4sRKipOcdpOu4GP6wR1axgO9rbtcZeKZScNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCM38K9wyKXHZ2nzsbw9melIr3fXBkwddb1pZN0J2hgVO8s3W9tAtY81lQD9BdamWsjapBFMXZ2agC1cy5zLkh8MqN2bvoj+r8kKehUBcK9ha7QBTwYx2Mg457jKKMrqV4ezguZl8dWHkNYCVZ+/7/B7fwOrm8oLb0sa3jOBCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WkRhNBZx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WkRhNBZx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A83C5175A;
	Thu, 26 Mar 2026 06:32:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A0D3F836;
	Thu, 26 Mar 2026 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774531959; bh=pVRjgvx4sRKipOcdpOu4GP6wR1axgO9rbtcZeKZScNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkRhNBZxbwBjOCmbpa+Vpq7Tow/n2qGhq6CWYdm45Wl5AHWL/y03ILfao74YspWWc
	 ZHJ670bVj/ewGZuWDBdEKXxi+LwmgCdQoT/pZi2KvyS/fYs1yNg1N/CsS6cfNdNhzP
	 2lVYtUwrkqNP+rYzL06890rAOpYAT9fbxbgQY9y0=
Date: Thu, 26 Mar 2026 13:32:26 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Elif Topuz <elif.topuz@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, d-gole@ti.com,
	jonathan.cameron@huawei.com, lukasz.luba@arm.com,
	philip.radford@arm.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 05/17] firmware: arm_scmi: Add Telemetry protocol
 support
Message-ID: <acU1arT1tMZVbe2m@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-6-cristian.marussi@arm.com>
 <02534a48-6795-4948-9348-fe507e8810fd@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02534a48-6795-4948-9348-fe507e8810fd@arm.com>

On Fri, Jan 23, 2026 at 11:00:46AM +0000, Elif Topuz wrote:
> 
> Hi Cristian,

HI Elif,

a long overdue reply from me !

Thanks for having a look at this series...

> 
> On 14/01/2026 11:46, Cristian Marussi wrote:
> > Add basic support for SCMI V4.0 Telemetry protocol including SHMTI,
> > FastChannels, Notifications and Single Sample Reads collection methods.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> >  - Add proper ioread accessors for TDCF areas
> >  - Rework resource allocation logic and lifecycle
> >  - Introduce new resources accessors and res_get() operation to
> >    implement lazy enumeration
> >  - Support boot-on telemetry:
> >    + Add DE_ENABLED_LIST cmd support
> >    + Add CONFIG_GET cmd support
> >    + Add TDCF_SCAN for best effort enumeration
> >    + Harden driver against out-of-spec FW with out of spec cmds
> >  - Use FCs list
> >  - Rework de_info_lookup to a moer general de_lookup
> >  - Fixed reset to use CONFIG_GET and DE_ENABLED_LIST to gather initial
> >    state
> >  - Using sign_extend32 helper
> >  - Added counted_by marker where appropriate
> > ---
> >  drivers/firmware/arm_scmi/Makefile    |    2 +-
> >  drivers/firmware/arm_scmi/driver.c    |    2 +
> >  drivers/firmware/arm_scmi/protocols.h |    1 +
> >  drivers/firmware/arm_scmi/telemetry.c | 2671 +++++++++++++++++++++++++
> >  include/linux/scmi_protocol.h         |  188 +-
> >  5 files changed, 2862 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/arm_scmi/telemetry.c
> > 

[snip]

> > +	/* Build composing DES string */
> > +	for (int i = 0; i < ti->info.base.num_groups; i++) {
> > +		struct scmi_telemetry_group *grp = &rinfo->grps[i];
> > +		size_t bufsize = grp->info->num_des * 11 + 1;
> > +		char *buf = grp->des_str;
> > +
> > +		for (int j = 0; j < grp->info->num_des; j++) {
> > +			char term = j != (grp->info->num_des - 1) ? ' ' : '\0';
> > +			int len;
> > +
> > +			len = scnprintf(buf, bufsize, "0x%04X%c",
> 
> I think it should be 0x%08X%c to print 8 bytes.
> 

Good catch ! I will fix..

> > +					rinfo->des[grp->des[j]]->info->id, term);
> > +
> > +			buf += len;
> > +			bufsize -= len;
> > +		}
> > +	}
> > +

[snip]

> > +
> > +static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
> > +					  struct payload __iomem *payld,
> > +					  struct telemetry_shmti *shmti,
> > +					  enum scan_mode mode)
> > +{
> > +	int used_qwords;
> > +
> > +	used_qwords = (USE_LINE_TS(payld) && TS_VALID(payld)) ?
> > +		QWORDS_TS_LINE_DATA_PAYLD : QWORDS_LINE_DATA_PAYLD;
> 
> If I understand correctly from the "chat with ATG" comments below, when
> timestamp is disabled (after DE is enabled with timestamp), physically ts line
> is still there (use_line_ts = 1 and ts_valid = 0). That's why I think we need to
> drop TS_VALID(payld) check. Otherwise qwords will be QWORDS_LINE_DATA_PAYLD
> although ts line exists.
> 
> Also, for the alpha version of the spec, the combination of use_line_ts = 1 and
> ts_valid = 0 doesn't seem to be possible as I understand. But I think beta
> version allows us?

Yes indeed ALPHA_0 definition of TS Line fields was ambiguos but now in
BETA the field is more explicitly called as LineExtension bit field...so
the code in the upcoming V3 will change accordingly.

> 
> > +
> > +	/* Invalid lines are not an error, could simply be disabled DEs */
> > +	if (DATA_INVALID(payld))
> > +		return used_qwords;
> > +
> > +	if (!IS_BLK_TS(payld))
> > +		scmi_telemetry_tdcf_data_parse(ti, payld, shmti, mode);
> > +	else
> > +		scmi_telemetry_tdcf_blkts_parse(ti, payld, shmti);
> > +
> > +	return used_qwords;
> > +}
> > +
> > +static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> > +				     unsigned int shmti_id, u64 ts,
> > +				     enum scan_mode mode)
> 
> ts is not used in the function.
> 

Yes indeed I have removed it in V3.

> > +{
> > +	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
> > +	struct tdcf __iomem *tdcf = shmti->base;
> > +	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
> > +	u64 startm = 0, endm = TDCF_BAD_END_SEQ;
> > +	void *eplg = SHMTI_EPLG(shmti);
> > +
> > +	if (!tdcf)
> > +		return -ENODEV;
> > +

[snip]

> > +
> > +		de_id = le32_to_cpu(payld->id);
> > +		de = xa_load(&ti->xa_des, de_id);
> > +		if (!de || !de->enabled) {
> > +			dev_err(ti->ph->dev,
> > +				"MSG - Received INVALID DE - ID:%u  enabled:%d\n",
> 
> enabled:%c?
> 

Yep

> > +				de_id, de ? (de->enabled ? 'Y' : 'N') : 'X');
> > +			continue;

[snip]

> >  struct scmi_power_state_changed_report {
> > @@ -1114,4 +1292,12 @@ struct scmi_powercap_meas_changed_report {
> >  	unsigned int	domain_id;
> >  	unsigned int	power;
> >  };
> > +
> > +struct scmi_telemetry_update_report {
> > +	ktime_t		timestamp;
> > +	unsigned int	agent_id;
> > +	int		status;
> > +	unsigned int	num_dwords;
> > +	unsigned int	dwords[];
> > +};
> >  #endif /* _LINUX_SCMI_PROTOCOL_H */
> 
> Thanks,
> Elif

Thanks for the review !
Cristian

PS: (nitpick) you should trim your review replies to remove all the long
bunch of code that you are not comenting on  (leaving a [snip] placeholder
as I did above)... it helps finding your comments in the sea of code...

