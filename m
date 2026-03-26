Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4F125A0;
	Thu, 26 Mar 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539352; cv=none; b=u8PhhFSRX9zlNWGgfxSWSUHPfQXBEge+cz79kzPZzfjw0qnrLelNlRlK4Xbtr3q1CyeaTfHuotzdLgjhhRDD8KHaxUC4Kq9a1UhG4RsmGIJL4rtGHu+XFgKY45VKpwnLCY5L8vJB+NmvueSh74NhFaYd80RxQFkuGVQBU6+g1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539352; c=relaxed/simple;
	bh=YVG0FlxMDpsJGDv7zlW5c/pCwoam9J4eKlhKt9Gme2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr8jKPhzdVG4NmcriCw2AJbzzMsFWd+8szFpZfHTC1ghgZQWU6KbrfJLqBuyvrp0DchgkOg47nFWLM/BmGAAzqCDa3W+IRkVQWOwdF94oGCGuRK/17GHGllYTMMCV1WZ+GOeDsjfAHg3blWauF7OS67KaWwWnkznFacMNdruY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JxnZgFS6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JxnZgFS6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B881D6F;
	Thu, 26 Mar 2026 08:35:42 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32803F99C;
	Thu, 26 Mar 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774539348; bh=YVG0FlxMDpsJGDv7zlW5c/pCwoam9J4eKlhKt9Gme2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxnZgFS6/t1fXTv5sC4XPGBHFE3vYzAx0W95PUg+xQv0C4b8U4xRYPY+nF+T9GMgI
	 3X9/FD2gPDF/fAfYsJLj0W/4B8e1fW7oBXrMuDzoCGHGMp3Qthr76Hg2hRS8oZ2dw1
	 YW11Fycd/oP6SPx+WqS1C/F24RjEKvsEs1QjdTzA=
Date: Thu, 26 Mar 2026 15:35:42 +0000
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
Subject: Re: [PATCH v2 07/17] firmware: arm_scmi: Use new Telemetry traces
Message-ID: <acVSTu5oqeZ6jA9f@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-8-cristian.marussi@arm.com>
 <3c6bddfd-a674-486c-add4-35ef93ec88c4@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6bddfd-a674-486c-add4-35ef93ec88c4@arm.com>

On Fri, Jan 23, 2026 at 11:43:37AM +0000, Elif Topuz wrote:
> 
> Hi Cristian,

Hi Elif,

> 
> On 14/01/2026 11:46, Cristian Marussi wrote:
> > Track failed SHMTI accesses and received notifications.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/telemetry.c | 57 ++++++++++++++++++++++-----
> >  1 file changed, 48 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> > index 16bcdcdc1dc3..443e032a3553 100644
> > --- a/drivers/firmware/arm_scmi/telemetry.c
> > +++ b/drivers/firmware/arm_scmi/telemetry.c
> > @@ -25,6 +25,8 @@
> >  #include "protocols.h"
> >  #include "notify.h"
> >  
> > +#include <trace/events/scmi.h>
> > +
> >  /* Updated only after ALL the mandatory features for that version are merged */
> >  #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> >  
> > @@ -1366,8 +1368,10 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
> >  
> >  	/* Check for spec compliance */
> >  	if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
> > -	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0))
> > +	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0)) {
> > +		trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
> >  		return;
> > +	}
> >  
> >  	/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
> >  	bts = scmi_telemetry_blkts_lookup(ti->ph->dev, &ti->xa_bts, payld);
> > @@ -1376,6 +1380,9 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
> >  
> >  	/* Update the descriptor with the lastest TS*/
> >  	scmi_telemetry_blkts_update(shmti->last_magic, bts);
> > +
> > +	trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
> > +			       bts->last_magic, "SHMTI_BLK_TS");
> >  }
> >  
> >  static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> > @@ -1393,8 +1400,10 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> >  	/* Is thi DE ID know ? */
> >  	tde = scmi_telemetry_tde_lookup(ti, de_id);
> >  	if (!tde) {
> > -		if (mode != SCAN_DISCOVERY)
> > +		if (mode != SCAN_DISCOVERY) {
> > +			trace_scmi_tlm_access(de_id, "DE_INVALID", 0, 0);
> >  			return;
> > +		}
> >  
> >  		/* In SCAN_DISCOVERY mode we allocate new DEs for unknown IDs */
> >  		tde = scmi_telemetry_tde_get(ti, de_id);
> > @@ -1462,6 +1471,8 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> >  		tde->last_ts = tstamp;
> >  	else
> >  		tde->last_ts = 0;
> > +
> > +	trace_scmi_tlm_collect(0, tde->de.info->id, tde->last_val, "SHMTI_DE_UPDT");
> 
> tde->last_ts instead of 0?
>

Yes, but I have reworked a lot the code so the traces also are moved
around a lot with different tags...also I move the trace definitions
before the protocol series in V3 and scattered the trace calls all
across the protocol patches, which I split a lot.
 
I tried anyway to follow your advice...well..anyway I doubt V3 will be
the last one :P, so you're welcome to complain...

> >  }
> >  
> >  static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
> > @@ -1507,8 +1518,10 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> >  		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
> >  
> >  		startm = TDCF_START_SEQ_GET(tdcf);
> > -		if (IS_BAD_START_SEQ(startm))
> > +		if (IS_BAD_START_SEQ(startm)) {
> > +			trace_scmi_tlm_access(0, "MSEQ_BADSTART", startm, 0);
> >  			continue;
> > +		}
> >  
> >  		/* On a BAD_SEQ this will be updated on the next attempt */
> >  		shmti->last_magic = startm;
> > @@ -1520,18 +1533,25 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> >  
> >  			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
> >  								     shmti, mode);
> > -			if (qwords < used_qwords)
> > +			if (qwords < used_qwords) {
> > +				trace_scmi_tlm_access(PAYLD_ID(next),
> > +						      "BAD_QWORDS", startm, 0);
> >  				return -EINVAL;
> > +			}
> >  
> >  			next += used_qwords * 8;
> >  			qwords -= used_qwords;
> >  		}
> >  
> >  		endm = TDCF_END_SEQ_GET(eplg);
> > +		if (startm != endm)
> > +			trace_scmi_tlm_access(0, "MSEQ_MISMATCH", startm, endm);
> >  	} while (startm != endm && --retries);
> >  
> > -	if (startm != endm)
> > +	if (startm != endm) {
> > +		trace_scmi_tlm_access(0, "TDCF_SCAN_FAIL", startm, endm);
> >  		return -EPROTO;
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -1923,6 +1943,8 @@ static void scmi_telemetry_scan_update(struct telemetry_info *ti, u64 ts)
> >  			tde->last_ts = tstamp;
> >  		else
> >  			tde->last_ts = 0;
> > +
> > +		trace_scmi_tlm_collect(ts, tde->de.info->id, tde->last_val, "FC_UPDATE");
> 
> tde->last_ts instead of ts?

Yes...but a lot of rework as said above...

> 
> >  	}
> >  }
> >  
> > @@ -2001,8 +2023,11 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
> >  		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
> >  
> >  		startm = TDCF_START_SEQ_GET(tdcf);
> > -		if (IS_BAD_START_SEQ(startm))
> > +		if (IS_BAD_START_SEQ(startm)) {
> > +			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_BADSTART",
> > +					      startm, 0);
> >  			continue;
> > +		}
> >  
> >  		/* Has anything changed at all at the SHMTI level ? */
> >  		scoped_guard(mutex, &tde->mtx) {
> > @@ -2018,11 +2043,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
> >  		if (DATA_INVALID(payld))
> >  			return -EINVAL;
> >  
> > -		if (IS_BLK_TS(payld))
> > +		if (IS_BLK_TS(payld)) {
> > +			trace_scmi_tlm_access(tde->de.info->id,
> > +					      "BAD_DE_META", 0, 0);
> >  			return -EINVAL;
> > +		}
> >  
> > -		if (PAYLD_ID(payld) != tde->de.info->id)
> > +		if (PAYLD_ID(payld) != tde->de.info->id) {
> > +			trace_scmi_tlm_access(tde->de.info->id, "DE_INVALID", 0, 0);
> >  			return -EINVAL;
> > +		}
> >  
> >  		/* Data is always valid since NOT handling BLK TS lines here */
> >  		*val = LINE_DATA_GET(&payld->l);
> > @@ -2046,10 +2076,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
> >  		}
> >  
> >  		endm = TDCF_END_SEQ_GET(tde->eplg);
> > +		if (startm != endm)
> > +			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_MISMATCH",
> > +					      startm, endm);
> >  	} while (startm != endm && --retries);
> >  
> > -	if (startm != endm)
> > +	if (startm != endm) {
> > +		trace_scmi_tlm_access(tde->de.info->id, "TDCF_DE_FAIL",
> > +				      startm, endm);
> >  		return -EPROTO;
> > +	}
> >  
> >  	guard(mutex)(&tde->mtx);
> >  	tde->last_magic = startm;
> > @@ -2230,6 +2266,9 @@ scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
> >  			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
> >  		else
> >  			tde->last_ts = 0;
> > +
> > +		trace_scmi_tlm_collect(timestamp, tde->de.info->id, tde->last_val,
> > +				       "MESSAGE");
> 
> tde->last_ts instead of timestamp? If I understand correctly, tde->last_ts
> corresponds to the time coming from the platform. We have kernel time anyway
> coming from ftrace format.

Yes good point...timestamp is the time of arrival of the
notification...I can also drop that parameter at this point...

Thanks a lot for reviewing !
Cristian
