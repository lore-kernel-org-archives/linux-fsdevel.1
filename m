Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F8383C79;
	Sun, 29 Mar 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802125; cv=none; b=LVUa/UZJW+usHOOcUx0dcWHDU1OPyxEgcyz33TEAeSb9MOZrnbYIh249P8+Mx3pa1mSwU+iHUNYpgz+VcKl/S4lRO4Hha01nZJOurf0FvxypnBSCQ8tW2rOoYGwmfimC3TlsruoE7Ak0YVvSyWZCSR4L+g2X6E6fRe8jnsHslVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802125; c=relaxed/simple;
	bh=X5bQX4K+cTC/K+nhDPIcHiJ5J7cork8b4fvkU8+UoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwegVcZQRYr5ozdj3KGBP9y7bQPs/sqT2Zgbh44q3PVo7OAbh59LYRImFkQP5SqDA0QgX75+lTPNgviQHCULDSQ9pX8PpMpLP+0ntUFXXGbgPfqnhYd06PwV7lzmpdwQcDwakz0dzkgpBgnlRJ+9/NpLpjxJVhZy/VdITSM9H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JALzPN0k; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JALzPN0k"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0959A3627;
	Sun, 29 Mar 2026 09:35:17 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE88A3F915;
	Sun, 29 Mar 2026 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802122; bh=X5bQX4K+cTC/K+nhDPIcHiJ5J7cork8b4fvkU8+UoWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JALzPN0kghD2dAwz5PdtYNSzjWo15WTEJbxk0eB5CwaLWWU6g1kax/gIv1ysH84WP
	 C+WfHG/y3sRjH28P+1UnMBYmpUWDhMiGYcHmda0d+WkLDsug16eyt1H/DCtE9/o/nq
	 2x0XuF+kTF33CPek5QEwSuO/acI12cjU044EoZiY=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 21/24] [RFC] docs: stlmfs: Document ARM SCMI Telemetry FS ABI
Date: Sun, 29 Mar 2026 17:33:32 +0100
Message-ID: <20260329163337.637393-22-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329163337.637393-1-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add full ABI dcoumentation for stlmfs under testing/

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2-->v3
 - complete ABI entries docs

RFC since the documentation is still NOT complete and unsure if place
this into stable/ or testing/
---
 Documentation/ABI/testing/stlmfs | 297 +++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)
 create mode 100644 Documentation/ABI/testing/stlmfs

diff --git a/Documentation/ABI/testing/stlmfs b/Documentation/ABI/testing/stlmfs
new file mode 100644
index 000000000000..0d9b1c1885a2
--- /dev/null
+++ b/Documentation/ABI/testing/stlmfs
@@ -0,0 +1,297 @@
+What:		/sys/fs/arm_telemetry/tlm_<N>/all_des_enable
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry to enable all the discovered Data Events for
+		SCMI instance <N>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/all_tstamp_des_enable
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry to enable timestamps for all the discovered
+		Data Events for SCMI instance <N>. (when available)
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/available_update_intervals_ms
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a space separated list of tuples of
+		values, separated by a coma, each one representing a
+		configurable update interval for SCMI instance <N>.
+		Each tuple describes a possible update interval using the
+		format <secs>,<exp> where the final represented interval is
+		calculated as: <secs> * 10 ^ <exp>
+		An example of list of tuples that can be read from this entry:
+			3,0 4,-1 75,-2 300,-3 1,1 5,3 222,-7
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/by_components/
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A subdirectory that exposes an alternative topological view of
+		the same set of discovered DEs that can be already found under
+		the des/ branch.
+		This topology subtree is built following this structure:
+		    by_components/
+		    ├── <COMPO_TYPE_STR>
+		    │   ├── <COMPO_ISTANCE_ID>
+		    │   │   ├── <DE_UNIT_TYPE_STR>
+		    │   │   │   └── <DE_INSTANCE_ID>
+		    │   │   │       └── 0x<DE_ID>[<DE_NAME>] -> ../../../../../des/0x<DE_ID>
+
+		The leaves are actual symlinks to an existing des/0x<DE_ID>
+		subdirectory, while the naming of the subdirectories composing
+		the inner nodes of the subtree are derived from the DataEvent
+		Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/control
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	An RW entry that can be used to discover, configure and retrieve
+		Telemetry data using the alternative binary interface based on
+		ioctls which is documented in include/uapi/linux/scmi.h
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/current_update_intervals_ms
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	An RW entry that can be used to get or set the platform update
+		interval for SCMI instance <N>.
+		On read the returned tuple represents the current update
+		interval using the format <secs>,<exp> where the final
+		represented interval is calculated as: <secs> * 10 ^ <exp>
+		On write the accepted format is the same as on read <secs>,<exp>
+		but, optionally, the second element of the tuple can be omitted
+		and in that case the assumed value for the exponent will default
+		to -3, i.e. milliseconds.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/de_implementation_version
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a string representing the 128bit UUID
+		that uniquely identifies the set of SCMI Telemetry Data Events
+		and their semantic for SCMI instance <N>.
+		This is compliant with the DE_IMPLEMENTATION_REVISION described
+		in SCMI v4.0 Telemetry 3.12.4.3.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des_bulk_read
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a multi-line string containing all the
+		the DEs enabled for SCMI instance <N>, one-per-line, formatted
+		as: <DE_ID> <TIMESTAMP> <DATA_VALUE>
+		These DEs readings represent the last value updated by the
+		platform following the configured update interval: on the
+		backend they will have been collected transparently in a number
+		of different ways: on-demand SHMTI lookup, notifications,
+		fastchannels.
+		Any disabled or unavailable DE is simply NOT included.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des_single_sample_read
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a multi-line string containing all the
+		the DEs enabled for SCMI instance <N>, one-per-line, formmatted
+		as: <DE_ID> <TIMESTAMP> <DATA_VALUE>
+		These DEs readings are generated by triggering an explicit and
+		immediate platform update using single sample asynchronous
+		collect methods.
+		Any disabled or unavailable DE is simply NOT included.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/intervals_discrete
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A boolean RO entry to specify if the intervals reported for
+		SCMI instance <N> in available_update_intervals_ms are a list of
+		discrete intervals or a triplet of values representing
+		<LOWEST_UPDATE_INTERVAL> <HIGHEST_UPDATE_INTERVAL> <STEP_SIZE>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/reset
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry that can be used the full reset of the SCMI
+		Telemetry subsystem, both of the configurations and of the
+		collected data, as specified in SCMI v4.0 3.12.4.12
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/tlm_enable
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A boolean RW entry that can be used to get or set the general
+		enable status of the Telemetry subsystem. Temporarily disabling
+		Telemetry as a whole does NOT reset the current configuration,
+		it only stops all the configured DEs updates platform side.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/version
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry used to report the SCMI Telemetry protocol version
+		used in this implementation.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/compo_instance_id
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the component instance to which this DE
+		belongs, as described by the DataEvent Descriptor in SCMI v4.0
+		3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/compo_type
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the component type to which this DE is
+		associated, as described by the DataEvent Descriptor in SCMI v4.0
+		3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/instance_id
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the DE instance ID that identifies this DE
+		within the component instance to which it belongs, as described
+		by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/name
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A optional RO entry to report the name associated with this DE,
+		as described by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/persistent
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO boolean to report that the DE data values are persistent
+		across all reboot cycles, except cold reboot, as described by
+		the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/tstamp_rate
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	An optional RO entry to report the clock rate in KHZ used to
+		generate the timestamps associated to this DE, as described by
+		the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/type
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the type of DataEvent as described by the
+		DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/unit
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the unit of measurements used by this DE,
+		as described by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/unit_exp
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the power-of-10 multiplier in two's
+		complement format that is applied to the unit specified by the
+		DE unit field, as described by the DataEvent Descriptor in SCMI
+		v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/value
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry used to read the last value and timestamp collected
+		for Data Event with id	0x<NNNNNNNN> for SCMI instance <N>.
+		The output is formatted as: <TIMESTAMP>: <DATA_VALUE>
+		Reading from this entry can fail with:
+		  -ENODATA: the DE itself, or the whole telemetry subsystem,
+			    was in a disabled state at the time of the read.
+		  -EINVAL: the data value associated to this DE is NOT usable
+			   since it was found to have been internally marked as
+			   DATA_INVALID; this could be due to a temporary or
+			   permanent error condition of the underlying hardware
+			   in charge of this DE data collection.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/enable
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RW boolean entry used to enable or disable Data Event
+		with id	0x<NNNNNNNN> for SCMI instance <N>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/tstamp_enable
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	An RW boolean entry used to enable or disable timestamping for
+		Data Event with id 0x<NNNNNNNN> for SCMI instance <N>.
+		This entry is optional and present only if the DE supports
+		timestamping.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/groups/<M>/
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A subdirectory containing entries that describe configurations
+		and values related to group <M> of SCMI instance <N>.
+		Most of the contained entries share the same names with some
+		other, already defined entries, elsewhere:
+
+			groups/0/
+			├── available_update_intervals_ms
+			├── control
+			├── current_update_interval_ms
+			├── des_bulk_read
+			├── des_single_sample_read
+			├── enable
+			├── intervals_discrete
+			└── tstamp_enable
+
+		These homonyms carry the same syntax and semantic as the other
+		but they are usually restricted in their definitions to the
+		specific group <M>.
+		These common entries won't be described further again here.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/groups/<M>/composing_des
+Date:		May 2026
+KernelVersion:	7.2
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that reports the space separated list of DataEvents
+		belonging to group <M> for SCMI instance <N>
+Users:		Any userspace telemetry tool
-- 
2.53.0

