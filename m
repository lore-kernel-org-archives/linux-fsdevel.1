Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3303331A56;
	Sat, 13 Jun 2026 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328936; cv=none; b=mKCN2CKnHrouvM2GTBmTNgU9HemCYSKMdRk6NsmmpyoBK0jOFYU98rsbQc1QWzZRQHvf40Gg4DCVJDi/tpp0loON4EpMXBNVUbAo9hs47kbyD0XyZt0pTke+wqPx5IeIkIiKwfikgu7pcqCtlvXF2jabjpR/5i56zEFT2s6E8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328936; c=relaxed/simple;
	bh=z1yRfRfrVF3upk2Qd54yzHxFRLHR7hAEahTsDC5Goic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7Rn5AcJRXljgwm+vGCZn5hn3kJrJC3CHl0+/Ih0uyjRCHOW8uVDz+Dmk0Owd0KUdI7xNtOsUnsAk2Mi0QE3Z7hYNo8ovuYZodcraNip5JDMK/rgEXzDYEBIRLCTdshWW9XsGecabrbudWoDaXt9TnagTI4el8V5TJ5xRwwe3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XHbJeVkY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHbJeVkY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WwOZTkRoALza710BPglWSnjfyn/AZ1mAUg08077jjNI=; b=XHbJeVkY8cEQTQo2b8PxGFzkPs
	NbBnZGnr8/tTTbDPsAT2sU6h3trkd37ZT0NASNBQibDcfb9SyWwZXP38kf9r8QmViI5Ms2Uy03jgo
	7E3xzLTvW/bq423xPLjhjUtIZQmEe74K6MFdwmej8JV3rdj1ztBAd+I74eeU52fa6sl4Q/u5g4efH
	wSo0fEjtisl/K1Y+1aGpx/OlskOKP+aQgRWIn51DYaF0tVAROJ8m8rv6G5jD+2Zz6HG4+ru7lMlsQ
	SCVAO9jJoURZcErHdwzhfkMpVrIsulysguTVgVkQhhhVKoesELoAkXsxaYLFYp+fypcjdGwRQCvnn
	Y2Ozl+pw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYH1o-0000000ByVT-41Wq;
	Sat, 13 Jun 2026 05:35:32 +0000
Message-ID: <09e893be-6a87-4fd5-805f-6fcae67485a5@infradead.org>
Date: Fri, 12 Jun 2026 22:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org, james.quinlan@broadcom.com,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, etienne.carriere@st.com,
 peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org,
 elif.topuz@arm.com, lukasz.luba@arm.com, philip.radford@arm.com,
 brauner@kernel.org, souvik.chakravarty@arm.com, leitao@kernel.org,
 kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev,
 kernel-team@meta.com
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/26 3:37 PM, Cristian Marussi wrote:
> Hi all,
> 
> --------------------------------------------------------------------------------
> [TLDR Summary]
> This series introduces a new SCMI driver which uses a new Telemetry FS to expose
> and configure SCMI Telemetry Data Events retrieved from the platform SCMI FW
> at runtime. The patches carrying the new STLMFS Filesystem support are tagged
> with 'stlmfs'.
> --------------------------------------------------------------------------------

> ---
>  - moved from SysFS/chardev to a full fledged FS
>  - added support for SCMI Telemetry BLK timestamps
> 

'make htmldocs' with all documentation patches applied says:

WARNING: linext-2026-0610/Documentation/ABI/testing/stlmfs:5: tag 'contact' is invalid
		Rationale:	This filesystem provides access to SCMI telemetry data and

WARNING: linext-2026-0610/Documentation/ABI/testing/stlmfs:21: tag 'contact' is invalid
		Concurrency:	The telemetry configuration exposed through this filesystem is

Documentation/ABI/testing/stlmfs:55: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/stlmfs:69: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/stlmfs:282: ERROR: Unexpected indentation. [docutils]

WARNING: linext-2026-0610/Documentation/ABI/testing/stlmfs:39: abi_sys_fs_arm_telemetry_tlm_n doesn't have a description
linext-2026-0610/Documentation/filesystems/stlmfs.rst:255: WARNING: Title underline too short.

by-components/
----------- [docutils]

linext-2026-0610/Documentation/filesystems/stlmfs.rst: WARNING: document isn't included in any toctree [toc.not_included]


Please correct these and run 'make htmldocs' to verify that they are fixed.

> 
> Thanks,
> Cristian
> 
> [0]: https://developer.arm.com/documentation/den0056/f/?lang=en
> [1]: https://lore.kernel.org/arm-scmi/20250620192813.2463367-1-cristian.marussi@arm.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/cris/linux.git/log/?h=scmi_telemetry_unified_fs_V4
> 
> Cristian Marussi (31):
>   firmware: arm_scmi: Add new SCMIv4.0 error codes definitions
>   firmware: arm_scmi: Reduce the scope of protocols mutex
>   firmware: arm_scmi: Allow registration of unknown-size events/reports
>   firmware: arm_scmi: Allow protocols to register for notifications
>   uapi: Add ARM SCMI definitions
>   dt-bindings: firmware: arm,scmi: Add support for telemetry protocol
>   include: trace: Add Telemetry trace events
>   firmware: arm_scmi: Add basic Telemetry support
>   firmware: arm_scmi: Add support to parse SHMTIs areas
>   firmware: arm_scmi: Add Telemetry configuration operations
>   firmware: arm_scmi: Add Telemetry DataEvent read capabilities
>   firmware: arm_scmi: Add support for Telemetry reset
>   firmware: arm_scmi: Add Telemetry notification support
>   firmware: arm_scmi: Add support for boot-on Telemetry
>   firmware: arm_scmi: Add Telemetry generation counter
>   firmware: arm_scmi: Add common per-protocol debugfs support
>   firmware: arm_scmi: Add Telemetry debugfs SHMTI dump support
>   firmware: arm_scmi: Add Telemetry debugfs ABI documentation
>   firmware: arm_scmi: stlmfs: Add System Telemetry filesystem driver
>   fs/stlmfs: Document ARM SCMI Telemetry filesystem
>   firmware: arm_scmi: stlmfs: Add basic mount options
>   fs/stlmfs: Document ARM SCMI Telemetry FS mount options
>   firmware: arm_scmi: stlmfs: Add ioctls support
>   fs/stlmfs: Document alternative ioctl based binary interface
>   firmware: arm_scmi: stlmfs: Add by-components view
>   fs/stlmfs: Document alternative topological view
>   firmware: arm_scmi: stlmfs: Add generation file
>   [RFC] docs: stlmfs: Document ARM SCMI Telemetry FS ABI
>   firmware: arm_scmi: stlmfs: Add lazy population support
>   fs/stlmfs: Document lazy mode and related mount option
>   [RFC] tools/scmi: Add SCMI Telemetry testing tool
> 
>  Documentation/ABI/testing/debugfs-scmi        |   22 +
>  Documentation/ABI/testing/stlmfs              |  348 ++
>  .../bindings/firmware/arm,scmi.yaml           |    8 +
>  Documentation/filesystems/stlmfs.rst          |  342 ++
>  MAINTAINERS                                   |    1 +
>  drivers/firmware/arm_scmi/Kconfig             |   24 +
>  drivers/firmware/arm_scmi/Makefile            |    3 +-
>  drivers/firmware/arm_scmi/common.h            |   10 +
>  drivers/firmware/arm_scmi/driver.c            |   93 +-
>  drivers/firmware/arm_scmi/notify.c            |   30 +-
>  drivers/firmware/arm_scmi/notify.h            |    8 +-
>  drivers/firmware/arm_scmi/protocols.h         |   13 +
>  .../firmware/arm_scmi/scmi_system_telemetry.c | 3146 ++++++++++++++++
>  drivers/firmware/arm_scmi/telemetry.c         | 3300 +++++++++++++++++
>  include/linux/scmi_protocol.h                 |  203 +-
>  include/trace/events/scmi.h                   |   48 +-
>  include/uapi/linux/scmi.h                     |  289 ++
>  tools/testing/scmi/Makefile                   |   25 +
>  tools/testing/scmi/stlm.c                     |  434 +++
>  19 files changed, 8307 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/ABI/testing/stlmfs
>  create mode 100644 Documentation/filesystems/stlmfs.rst
>  create mode 100644 drivers/firmware/arm_scmi/scmi_system_telemetry.c
>  create mode 100644 drivers/firmware/arm_scmi/telemetry.c
>  create mode 100644 include/uapi/linux/scmi.h
>  create mode 100644 tools/testing/scmi/Makefile
>  create mode 100644 tools/testing/scmi/stlm.c
> 

-- 
~Randy

