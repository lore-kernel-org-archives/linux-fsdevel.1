Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878A280309;
	Tue, 28 Jul 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202085; cv=none; b=NCcRfUedRLrb27uyxXPlv2BDJ4qD/PuhvG7Op1QidvQS3Yt7+heIh2F8P9qRxBs0Tf50S7Ve9sBAaCRtydEVczmURdzruihJFwWX5N+vMQrD+6k/1FuNxMQNmzxa58JqGKgUg6VK4xBIldfAQjBj3m7sBhkdUIVemXFakUl8OwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202085; c=relaxed/simple;
	bh=7yE+Z2OqalwumC3mTZsbiarDa/DLROa2HsGFlraCiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vw5jV1Fem+2GAbdo3b5aL5L9hNAb8M3FXCJCTG899TV+EXYb5YRcvLwvPrOzq/oyeLac0ZzgY/qFE8B7aLFC0lUpPOyUQj6n+DAoY0Xu3qhuryMUqlXTPb0JBCroIemXiAxM37QOycDnySoNQeoX9kDkjccXE/k6ODjGqdw6oNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcZ9CYXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcZ9CYXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97481F000E9;
	Tue, 28 Jul 2026 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202083;
	bh=gAt0aFb//7A4/4ojCI627rMD2TYOoTKvOVzgtO5822o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EcZ9CYXY+6ORNqJpKDPgphZw+iyTKMJmkRFubdUHcgWIDOV7f0FbXz+BMz4URD2rF
	 X4e3f9y5xdztiqdAUS0MCf0u6gyBZ/qVc4eDHyScYO88vIafJ1fJIiP7iBy96QZEM4
	 1CADh3igw1O+EvLNf2P22htUrcTWn8OFlQXkRT9XnL7YmWW/NhEjILScFUm2mfMuab
	 6svtNwcaGacZo910zNuQ/JuKsuSqQnND9L4Vp0borw1tiUrxc0DAokINbcSHhmCBGG
	 boc01GP6xmoHTQnpiHmolRHQWFL4QjyMqntypoo7jJZA/Ja91FRpDWbsV7dfiR0rHS
	 h1KheDOd7qBFw==
Date: Tue, 28 Jul 2026 02:27:59 +0100
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
Subject: Re: [PATCH v6 06/22] firmware: arm_scmi: Add basic Telemetry
 support
Message-ID: <20260728022759.5c485c1c@jic23-huawei>
In-Reply-To: <20260724144430.1440170-7-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
	<20260724144430.1440170-7-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:44:14 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add SCMIv4.0 Telemetry basic support to enable initialization and resources
> enumeration: add all the telemetry messages definitions and parsing logic
> but only a few simple state gathering protocol operations.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v5 --> v6
>  - define uuid_line dwords as BE
>  - fixed Sashiko reviews where applicable:
>    https://sashiko.dev/#/message/20260703123601.381275-8-cristian.marussi%40arm.com
>    - fix missing le32 and bound check in variable payload parsing
>    - fix TDE duplicatin logic
>    - fix intervals cleanup - fixes also KMEMLEAK report
>    - implement proper freeinfg for group resources
>    - proper SHMTI iterations
>    - removed useless/stale static in scmi_telemetry_tde_get()
> v4 --> v5
>  - fix de->grp_id initialization for DEs not belonging to a group
>  - removed UAPI structures dependency
>  - expose discovered SHMTIs areas in scmi_protocol.h
>  - fixes sparse warnings
> v3 -->v4
>  - bail-out on FW_BUG errors
>  - count timestamp capable DE to track enables
> v2 --> v3
>  - split from monolithic Telemetry patch
>  - fix checkpatch macros complaints
>  - fix ACCESS_PRIVATE usage
>  - add a few comments on allocation/enumeration lifetime
>  - use interval.num_intervals
>  - removed needless cleanup handler usage
>  - simply return from scmi_telemetry_de_lookup()
>  - fixed composing_des name length to 08X
> ---
>  drivers/firmware/arm_scmi/Makefile    |    2 +-
>  drivers/firmware/arm_scmi/driver.c    |    2 +
>  drivers/firmware/arm_scmi/protocols.h |    1 +
>  drivers/firmware/arm_scmi/telemetry.c | 1442 +++++++++++++++++++++++++
>  include/linux/scmi_protocol.h         |  181 +++-
>  5 files changed, 1626 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/telemetry.c
> 
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 780cd62b2f78..fe55b7aa0707 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -8,7 +8,7 @@ scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> -scmi-protocols-y += pinctrl.o
> +scmi-protocols-y += pinctrl.o telemetry.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += transports/
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 0f9e8dfc6137..4c200b6168a9 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3587,6 +3587,7 @@ static int __init scmi_driver_init(void)
>  	scmi_system_register();
>  	scmi_powercap_register();
>  	scmi_pinctrl_register();
> +	scmi_telemetry_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3605,6 +3606,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
>  	scmi_pinctrl_unregister();
> +	scmi_telemetry_unregister();
>  
>  	platform_driver_unregister(&scmi_driver);
>  
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index b7f29003a7dc..1f9925b8f495 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -401,5 +401,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
>  DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
>  DECLARE_SCMI_REGISTER_UNREGISTER(system);
>  DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
> +DECLARE_SCMI_REGISTER_UNREGISTER(telemetry);
>  
>  #endif /* _SCMI_PROTOCOLS_H */
> diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> new file mode 100644
> index 000000000000..372051ad1e62
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/telemetry.c
> @@ -0,0 +1,1442 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Telemetry Protocol
> + *
> + * Copyright (C) 2026 ARM Ltd.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/compiler_types.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/sprintf.h>
> +#include <linux/string.h>
> +#include <linux/xarray.h>
> +
> +#include "protocols.h"
> +#include "notify.h"
> +
> +#include <trace/events/scmi.h>
> +
> +/* Updated only after ALL the mandatory features for that version are merged */
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> +
> +#define SCMI_TLM_TDCF_MAX_RETRIES	5
> +
> +enum scmi_telemetry_protocol_cmd {

I'd add a comment to say where 1 and 2 went (standards across protocols I assume?)

> +	TELEMETRY_LIST_SHMTI = 0x3,
> +	TELEMETRY_DE_DESCRIPTION = 0x4,
> +	TELEMETRY_LIST_UPDATE_INTERVALS = 0x5,
> +	TELEMETRY_DE_CONFIGURE = 0x6,
> +	TELEMETRY_DE_ENABLED_LIST = 0x7,
> +	TELEMETRY_CONFIG_SET = 0x8,
> +	TELEMETRY_READING_COMPLETE = TELEMETRY_CONFIG_SET,

That is odd enough I'd add a comment or a reference to the delayed response
section of the spec.

> +	TELEMETRY_CONFIG_GET = 0x9,
> +	TELEMETRY_RESET = 0xA,
> +};
> +
> +struct scmi_msg_resp_telemetry_protocol_attributes {
> +	__le32 de_num;
> +	__le32 groups_num;
> +	__le32 de_implementation_rev_dword[SCMI_TLM_DE_IMPL_MAX_DWORDS];

MAX seems odd given it is always this size I think?
 
> +	__le32 attributes;
> +#define SUPPORTS_SINGLE_READ(x)		(le32_get_bits((x), BIT(31)))
> +#define SUPPORTS_CONTINUOS_UPDATE(x)	(le32_get_bits((x), BIT(30)))
> +#define SUPPORTS_PER_GROUP_CONFIG(x)	(le32_get_bits((x), BIT(18)))
> +#define SUPPORTS_RESET(x)		(le32_get_bits((x), BIT(17)))
> +#define SUPPORTS_FC(x)			(le32_get_bits((x), BIT(16)))
See below for suggestion on an extractor for the other field (or a mask definition
at least)

> +	__le32 default_blk_ts_rate;
> +};
> +
> +struct scmi_telemetry_update_notify_payld {

These definitions are scattered enough across the spec that I think some comments
to helpfully tell a reader where to go look would be good.

> +	__le32 agent_id;
> +	__le32 status;
> +	__le32 num_dwords;
> +	__le32 array[] __counted_by(num_dwords);

__counted_by_le() 

as will be broken on big endian if you just use __counted_by()
The _le variant just elides the marking when compiling for big endian.


> +};
> +
> +struct scmi_shmti_desc {
Particularly useful to have a spec reference for this one given
the info is buried in an element of a table.

> +	__le32 id;
> +	__le32 addr_low;
> +	__le32 addr_high;
> +	__le32 length;
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_resp_telemetry_shmti_list {
> +	__le32 num_shmti;
> +	struct scmi_shmti_desc desc[] __counted_by(num_shmti);
__counted_by_le()
> +};
> +
> +struct de_desc_fc {
> +	__le32 addr_low;
> +	__le32 addr_high;
> +	__le32 size;
> +};
> +
> +struct scmi_de_desc {
> +	__le32 id;
> +	__le32 grp_id;
> +	__le32 data_sz;
> +	__le32 attr_1;
> +#define	IS_NAME_SUPPORTED(d)	(le32_get_bits((d)->attr_1, BIT(31)))
> +#define	IS_FC_SUPPORTED(d)	(le32_get_bits((d)->attr_1, BIT(30)))
> +#define	GET_DE_TYPE(d)		(le32_get_bits((d)->attr_1, GENMASK(29, 22)))
> +#define	IS_PERSISTENT(d)	(le32_get_bits((d)->attr_1, BIT(21)))
> +#define GET_DE_UNIT_EXP(d)						\
> +	({								\
> +		__u32 __signed_exp =					\
> +			le32_get_bits((d)->attr_1, GENMASK(20, 13));	\
> +									\
> +		sign_extend32(__signed_exp, 7);				\
> +	})
Can you not do something like

#define GET_DE_UNIT_EXP(d) \
	sign_extend32(le32_get_bits(d->attr_1, GENMASK(20, 13)), 7);

> +#define	GET_DE_UNIT(d)		(le32_get_bits((d)->attr_1, GENMASK(12, 5)))
> +#define	TSTAMP_SUPPORT(d)	(le32_get_bits((d)->attr_1, GENMASK(1, 0)))
> +	__le32 attr_2;
> +#define	GET_DE_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(31, 24)))
> +#define	GET_COMPO_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(23, 8)))
> +#define	GET_COMPO_TYPE(d)	(le32_get_bits((d)->attr_2, GENMASK(7, 0)))
> +	__le32 reserved;


> +};
> +
> +#define SCMI_TDE_VAR_SZ(_t)	

I'd go with a static inline function for this unless there is some
usecase where that doesn't work
					       \
> +	({								       \
> +		struct telemetry_de *__t = _t;				       \
> +		size_t _sz = 0;						       \
> +									       \
> +		_sz += __t->ts_type == TSTAMP_LINE ? sizeof(__le32) : 0;       \
> +		_sz += __t->de.fc_support ? sizeof(struct de_desc_fc) : 0;     \
> +		_sz += __t->de.name_support ? SCMI_SHORT_NAME_MAX_SIZE : 0;    \
> +									       \
> +		_sz;							       \
> +	})
> +
> +struct scmi_msg_resp_telemetry_de_description {
> +	__le32 num_desc;
> +	struct scmi_de_desc desc[] __counted_by(num_desc);

__counted_by_le()

How does this work when it's a variable sized element?

> +};
> +
> +struct scmi_msg_telemetry_update_intervals {
> +	__le32 index;
> +	__le32 group_identifier;
> +#define	ALL_DES_NO_GROUP	0x0
> +#define SPECIFIC_GROUP_DES	0x1
> +#define ALL_DES_ANY_GROUP	0x2

Probably want an le32_encode_bits() or something like that for these
similar to the macros you have going the other way.

> +	__le32 flags;
> +};
> +
> +struct scmi_msg_resp_telemetry_update_intervals {
> +	__le32 flags;
> +#define INTERVALS_DISCRETE(x)	(le32_get_bits((x), BIT(12)) == 0)
> +	__le32 intervals[];
> +};
> +
> +struct scmi_msg_telemetry_de_enabled_list {
> +	__le32 index;
> +	__le32 flags;
> +};
> +
> +struct scmi_enabled_de_desc {
> +	__le32 id;
> +	__le32 mode;

Maybe define an extraction macro for the mode field.

I'm not sure calling the whole thing mode makes sense as most likely any  new fields
that go in there in future won't be mode related.

> +};
> +
> +struct scmi_msg_resp_telemetry_de_enabled_list {
> +	__le32 flags;
> +	struct scmi_enabled_de_desc entry[];
> +};
> +
> +struct scmi_msg_telemetry_de_configure {
> +	__le32 id;
> +	__le32 flags;
> +#define DE_ENABLE_NO_TSTAMP	BIT(0)
> +#define DE_ENABLE_WTH_TSTAMP	BIT(1)
> +#define DE_DISABLE_ALL		BIT(2)
> +#define GROUP_SELECTOR		BIT(3)
> +#define EVENT_DE		0
> +#define EVENT_GROUP		1
> +#define DE_DISABLE_ONE		0x0
> +};
> +
> +struct scmi_msg_resp_telemetry_de_configure {
> +	__le32 shmti_id;
> +#define IS_SHMTI_ID_VALID(x)	((x) != 0xFFFFFFFF)
> +	__le32 shmti_de_offset;
> +	__le32 blk_ts_offset;
> +};
> +
> +struct scmi_msg_telemetry_config_set {
> +	__le32 grp_id;
> +	__le32 control;
> +#define TELEMETRY_ENABLE		(BIT(0))
> +
> +#define TELEMETRY_MODE_SET(x)		(FIELD_PREP(GENMASK(4, 1), (x)))

Not an le specific call?

> +#define	TLM_ONDEMAND			(0)
> +#define	TLM_NOTIFS			(1)
> +#define	TLM_SINGLE			(2)
> +#define TELEMETRY_MODE_ONDEMAND		TELEMETRY_MODE_SET(TLM_ONDEMAND)
> +#define TELEMETRY_MODE_NOTIFS		TELEMETRY_MODE_SET(TLM_NOTIFS)
> +#define TELEMETRY_MODE_SINGLE		TELEMETRY_MODE_SET(TLM_SINGLE)
> +
> +#define TLM_ORPHANS			(0)
> +#define TLM_GROUP			(1)
> +#define TLM_ALL				(2)
> +#define TELEMETRY_SET_SELECTOR(x)	(FIELD_PREP(GENMASK(8, 5), (x)))
same for this one.

> +#define	TELEMETRY_SET_SELECTOR_ORPHANS	TELEMETRY_SET_SELECTOR(TLM_ORPHANS)
> +#define	TELEMETRY_SET_SELECTOR_GROUP	TELEMETRY_SET_SELECTOR(TLM_GROUP)
> +#define	TELEMETRY_SET_SELECTOR_ALL	TELEMETRY_SET_SELECTOR(TLM_ALL)
> +	__le32 sampling_rate;
> +};
> +
> +struct scmi_msg_resp_telemetry_reading_complete {
> +	__le32 num_dwords;
> +	__le32 dwords[] __counted_by(num_dwords);
__counted_by_le()

> +};
> +
> +struct scmi_msg_telemetry_config_get {
> +	__le32 grp_id;
> +	__le32 flags;
> +#define TELEMETRY_GET_SELECTOR(x)	(FIELD_PREP(GENMASK(3, 0), (x)))

Seems likely wants to be an le32 specific one again.

> +#define	TELEMETRY_GET_SELECTOR_ORPHANS	TELEMETRY_GET_SELECTOR(TLM_ORPHANS)
> +#define	TELEMETRY_GET_SELECTOR_GROUP	TELEMETRY_GET_SELECTOR(TLM_GROUP)
> +#define	TELEMETRY_GET_SELECTOR_ALL	TELEMETRY_GET_SELECTOR(TLM_ALL)
> +};
> +
> +struct scmi_msg_resp_telemetry_config_get {
> +	__le32 control;
> +	__le32 sampling_rate;
> +};
> +
> +/* TDCF */
> +
> +#define _I(__a)		(ioread32((void __iomem *)(__a)))
> +
> +#define TO_CPU_64(h, l)	((((u64)(h)) << 32) | (l))

Used?  Generally these are bad idea anyway because the parameter order isn't
obvious.

> +
> +/*
> + * Define the behaviour of a SHMTI scan defining what information will
> + * be gathered and which Telemetry items can be updated.
> + */
> +enum scan_mode {
> +	SCAN_LOOKUP,	/* Update only value/tstamp */
> +	SCAN_UPDATE,	/* Update also location offset */
> +	SCAN_DISCOVERY  /* Update xa_des: allows for new DEs to be discovered */
> +};
> +
> +struct fc_line {
> +	__le32 data_low;
> +	__le32 data_high;
> +};
> +
> +struct fc_tsline {
> +	__le32 data_low;
> +	__le32 data_high;
> +	__le32 ts_low;
> +	__le32 ts_high;
> +};
> +
> +struct line {
> +	__le32 data_low;
> +	__le32 data_high;
> +};
> +
> +struct blk_tsline {
> +	__le32 ts_low;
> +	__le32 ts_high;
> +};
> +
> +struct tsline {
> +	__le32 data_low;
> +	__le32 data_high;
> +	__le32 ts_low;
> +	__le32 ts_high;
> +};
> +
> +struct uuid_line {
> +	__be32 dwords[SCMI_TLM_DE_IMPL_MAX_DWORDS];
> +};
> +
> +enum tdcf_line_types {
> +	TDCF_DATA_LINE,

Where an enum is used for spec defined values I'd always set them all
explicitly. Makes for easy spec vs code checking and makes it clear that
values matter.

> +	TDCF_BLK_TS_LINE,
> +	TDCF_UUID_LINE,
> +};
> +
> +struct payload {
> +	__le32 meta;
> +#define LINE_TYPE(x)		(FIELD_GET(GENMASK(7, 4), _I(&((x)->meta))))

Same as above about endianness.

> +#define IS_DATA_LINE(x)		(LINE_TYPE(x) == TDCF_DATA_LINE)
> +#define IS_BLK_TS_LINE(x)	(LINE_TYPE(x) == TDCF_BLK_TS_LINE)
> +#define IS_UUID_LINE(x)		(LINE_TYPE(x) == TDCF_UUID_LINE)
> +#define USE_BLK_TS(x)		(_I(&((x)->meta)) & BIT(3))
> +#define HAS_LINE_EXT(x)		(_I(&((x)->meta)) & BIT(2))
> +#define LINE_TS_VALID(x)	(_I(&((x)->meta)) & BIT(1))
> +#define	DATA_INVALID(x)		(_I(&((x)->meta)) & BIT(0))
> +#define	BLK_TS_INVALID(p)					\
> +({								\
> +	typeof(p) _p = (p);					\
> +	bool invalid;						\
> +								\
> +	invalid  = LINE_TS_VALID(_p) || HAS_LINE_EXT(_p) ||	\
> +			USE_BLK_TS(_p) || DATA_INVALID(_p);	\
> +	invalid;						\
> +})
I'm not sure why this needs a copy of p rather than just using
it directly and why it can't just be a simple macro.
Don't worry if checkpatch complains about these.

> +
> +#define	UUID_INVALID(p)						\
> +({								\
> +	typeof(p) _p = (p);					\
> +	bool invalid;						\
> +								\
> +	invalid = LINE_TS_VALID(_p) || USE_BLK_TS(_p) ||	\
> +			DATA_INVALID(_p) || !HAS_LINE_EXT(_p);	\
> +	invalid;						\
> +})
> +	__le32 id;
> +	union {
> +		struct line l;
> +		struct tsline tsl;
> +		struct blk_tsline blk_tsl;
> +		struct uuid_line uuid_l;
> +	};
> +};

> +struct prlg {
> +	u32 sign_start;
> +#define SIGNATURE_START	0x5442474E	/* TBGN */
> +	u32 match_start;
> +	u32 num_qwords;
> +	u32 hdr_meta_1;
> +#define TDCF_REVISION_GET(x)	(le32_get_bits((x)->hdr_meta_1, GENMASK(7, 0)))

This rather implies wrong type and that this whole thing needs to have
careful endianness handling.

> +};
> +
> +struct eplg {
> +	u32 match_end;
> +	u32 sign_end;
> +#define SIGNATURE_END	0x54454E44	/* TEND */
> +};
> +
> +#define TDCF_EPLG_SZ	(sizeof(struct eplg))
> +
> +struct tdcf {
> +	struct prlg prlg;
> +	unsigned char payld[];
> +};
> +
> +#define QWORDS(_t)	(_I(&(_t)->prlg.num_qwords))
> +
> +#define SHMTI_MIN_SIZE	(sizeof(struct tdcf) + TDCF_EPLG_SZ)
> +
> +#define TDCF_START_SIGNATURE(x)	(_I(&((x)->prlg.sign_start)))
> +#define TDCF_START_SEQ_GET(x)	(_I(&((x)->prlg.match_start)))
> +#define IS_BAD_START_SEQ(s)	((s) & 0x1)
> +
> +#define TDCF_END_SEQ_GET(e)	(_I(&((e)->match_end)))
> +#define TDCF_END_SIGNATURE(e)	(_I(&((e)->sign_end)))
> +#define	TDCF_BAD_END_SEQ	GENMASK(31, 0)
> +
> +struct telemetry_shmti {
> +	u32 flags;
> +	void __iomem *base;
> +	u32 last_magic;
> +	struct scmi_telemetry_shmti_info info;
> +};
> +
> +#define SHMTI_EPLG(s)						\

Why not a function? I was kind of expecting this to be used on a mix of data types
but it seems to only be the one.

> +	({							\
> +		struct telemetry_shmti *_s = (s);		\
> +		struct eplg __iomem *_eplg;			\
> +								\
> +		_eplg = _s->base + _s->info.len - TDCF_EPLG_SZ;	\
> +		(_eplg);					\
> +	})
> +
> +struct telemetry_line {
> +	refcount_t users;
> +	u32 last_magic;
> +	struct payload __iomem *payld;
> +	/* Protect line accesses  */

Also only one space before *

> +	struct mutex mtx;
> +};
> +
> +struct telemetry_block_ts {
> +	u64 last_ts;
> +	u32 last_rate;
> +	struct telemetry_line line;
> +};
> +
> +#define to_blkts(l)	container_of(l, struct telemetry_block_ts, line)
> +
> +struct telemetry_uuid {
> +	u32 de_impl_version[SCMI_TLM_DE_IMPL_MAX_DWORDS];
> +	struct telemetry_line line;
> +};
> +
> +#define to_uuid(l)	container_of(l, struct telemetry_uuid, line)
> +
> +enum timestamps {
> +	TSTAMP_NONE,
> +	TSTAMP_LINE,
> +	TSTAMP_BLK

Add a trailing comma. Rule of thumb is that if it doesn't have
a terminating entry the comma should always be there even if you
don't expect to extend it any time soon.

> +};
> +
> +struct telemetry_de {
> +	enum timestamps ts_type;
> +	u32 ts_rate;
> +	bool enumerated;
> +	bool cached_msg;
> +	void __iomem *base;
> +	struct eplg __iomem *eplg;
> +	u32 offset;
> +	/* NOTE THAT DE data_sz is registered in scmi_telemetry_de */
> +	u32 fc_size;
> +	/* Protect last_val/ts/magic accesses  */
> +	struct mutex mtx;
> +	u64 last_val;
> +	u64 last_ts;
> +	u32 last_magic;
> +	struct list_head item;
> +	struct telemetry_block_ts *bts;
> +	struct telemetry_uuid *uuid;
> +	struct scmi_telemetry_de de;
> +};
> +
> +#define to_tde(d)	container_of(d, struct telemetry_de, de)
> +
> +#define DE_ENABLED_WITH_TSTAMP	2
> +
> +struct telemetry_info {
> +	bool streaming_mode;
> +	unsigned int num_shmti;
> +	unsigned int num_des_tstamp;
> +	unsigned int default_blk_ts_rate;
> +	const struct scmi_protocol_handle *ph;
> +	struct telemetry_shmti *shmti;
> +	struct telemetry_de *tdes;
> +	struct scmi_telemetry_group *grps;
> +	struct xarray xa_des;
> +	/* Mutex to protect access to @free_des */
> +	struct mutex free_mtx;
> +	struct list_head free_des;
> +	struct list_head fcs_des;
> +	struct scmi_telemetry_info info;
> +	atomic_t rinfo_initializing;
> +	struct completion rinfo_initdone;
> +	struct scmi_telemetry_res_info *rinfo;
> +	struct scmi_telemetry_res_info *(*res_get)(struct telemetry_info *ti);
> +};
> +
> +static int scmi_telemetry_tde_register(struct telemetry_info *ti,
> +				       struct telemetry_de *tde)
> +{
> +	struct scmi_telemetry_res_info *rinfo = ti->rinfo;
> +	int ret;
> +
> +	if (rinfo->num_des >= ti->info.base.num_des) {
> +		ret = -ENOSPC;
> +		goto err;
> +	}
> +
> +	/* Store DE pointer by de_id ... */
> +	ret = xa_insert(&ti->xa_des, tde->de.info->id, &tde->de, GFP_KERNEL);
> +	if (ret)
> +		goto err;
> +
> +	/* ... and in the general array */
> +	rinfo->des[rinfo->num_des++] = &tde->de;
> +
> +	return 0;
> +
> +err:
> +	dev_err(ti->ph->dev, "Cannot register DE for ID:0x%08X\n",
> +		tde->de.info->id);
> +

I'd print and return at each error path given you can give a more useful
error message perhaps.

> +	return ret;
> +}


> +static int
> +scmi_telemetry_protocol_attributes_get(struct telemetry_info *ti)
> +{
> +	struct scmi_msg_resp_telemetry_protocol_attributes *resp;
> +	const struct scmi_protocol_handle *ph = ti->ph;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> +				      sizeof(*resp), &t);
> +	if (ret)
> +		return ret;
> +
> +	resp = t->rx.buf;
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		__le32 attr = resp->attributes;
> +
> +		ti->info.base.num_des = le32_to_cpu(resp->de_num);
> +		ti->info.base.num_groups = le32_to_cpu(resp->groups_num);
> +		for (int i = 0; i < SCMI_TLM_DE_IMPL_MAX_DWORDS; i++)
> +			ti->info.base.de_impl_version[i] =
> +				le32_to_cpu(resp->de_implementation_rev_dword[i]);
> +		ti->info.single_read_support = SUPPORTS_SINGLE_READ(attr);
> +		ti->info.continuos_update_support = SUPPORTS_CONTINUOS_UPDATE(attr);
> +		ti->info.per_group_config_support = SUPPORTS_PER_GROUP_CONFIG(attr);
> +		ti->info.reset_support = SUPPORTS_RESET(attr);
> +		ti->info.fc_support = SUPPORTS_FC(attr);
> +		ti->num_shmti = le32_get_bits(attr, GENMASK(15, 0));

Given the various other macros to break up attributes_1 maybe just have one for this
as well?  Would keep the definitions of all the fields in one place.

> +		ti->default_blk_ts_rate = le32_to_cpu(resp->default_blk_ts_rate);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}

Very much a partial review. Sending what I have as not sure when I'll get
back to this series.

Thanks,

Jonathan
