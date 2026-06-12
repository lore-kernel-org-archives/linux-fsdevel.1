Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162B407579;
	Fri, 12 Jun 2026 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304036; cv=none; b=W90pCAlAy8/VnL8Wcp+4ZFsbMe4xbyC7njWKp158ZfESgC3OtfL+earMIkI8F4YyAsDmzR3WhSeM0xTnNmw3fyILdR6CFz3D4yzf49kXbedEugMHRz3xH9HMoD3Rz9kwiw8aeyYbFe7LYQQh80lVm52mhhfm/wUts6x4d50mWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304036; c=relaxed/simple;
	bh=xtUzXB03/j7MlQyfEQXeYbDJFsUOLzL5rPpO1dREpgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIIGDA6Xh+W7wqPqUH8kN7beExOJq0PY5frrp/bub+yMGloWlPdSlCQ7Dt90618IM6W8hxiTW7BzHLz4eN5/Cx5FJA4RfGRCVdvZLbplYApWpZCL5GSfqYgwN2M63sOwa0UslsjvBaXTGz9P1GIdjOawyRqjD+6jaa/qs3ffX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rNzqXwIt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rNzqXwIt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2367849FF;
	Fri, 12 Jun 2026 15:40:29 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0EBB3FB7F;
	Fri, 12 Jun 2026 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304033; bh=xtUzXB03/j7MlQyfEQXeYbDJFsUOLzL5rPpO1dREpgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNzqXwIt+ClQJt3LUksun103iLK4R35bXXKbmyCZc3ZAPvyA7Ijas/v9xC2yA4XON
	 4HEsX7FNKi5sSLN0w6FRnssYLOMdAsezo8j4bcPyH4jAQ1ijxV/iTShJGFf9+PyxiF
	 npuID1+EZAK0tZoSzN9kHDTUYv3CW7s40dv836uA=
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
	d-gole@ti.com,
	jic23@kernel.org,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	leitao@kernel.org,
	kas@kernel.org,
	puranjay@kernel.org,
	usama.arif@linux.dev,
	kernel-team@meta.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 28/31] [RFC] docs: stlmfs: Document ARM SCMI Telemetry FS ABI
Date: Fri, 12 Jun 2026 23:37:58 +0100
Message-ID: <20260612223802.1337232-29-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
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
v3 --> v4
 - renamed to by-components
 - updated date/versions
 - changed output of des/0x<NNN>/value to -> <tstamp> <value>
   (removed colon)
 - added Rationale and Concurrency model
 - added generation counter Description
v2 --> v3
 - complete ABI entries docs

RFC since unsure if place this into stable/ or testing/
---
 Documentation/ABI/testing/stlmfs | 348 +++++++++++++++++++++++++++++++
 1 file changed, 348 insertions(+)
 create mode 100644 Documentation/ABI/testing/stlmfs

diff --git a/Documentation/ABI/testing/stlmfs b/Documentation/ABI/testing/stlmfs
new file mode 100644
index 000000000000..826092a4baf4
--- /dev/null
+++ b/Documentation/ABI/testing/stlmfs
@@ -0,0 +1,348 @@
+What:		/sys/fs/arm_telemetry/tlm_<N>/...
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Rationale:	This filesystem provides access to SCMI telemetry data and
+		configuration.
+		The interface is required to support:
+		- hierarchical dynamically discovered telemetry objects
+		- bulk data read across multiple sources
+		- representation of complex structured data and their
+		  relationship
+		- alternative high-frequency data access (ioctl/mmap)
+		These characteristics exceed the intended use of sysfs, which is
+		designed to represent devices properties with simple attribute
+		based configuration with one value per file: representing
+		telemetry Data Events with devices was deemed an abuse by
+		itself.
+		A dedicated filesystem is therefore used to provide a more
+		suitable abstraction for this class of functionality.
+
+Concurrency:	The telemetry configuration exposed through this filesystem is
+		global to each SCMI telemetry instance, indentified by the top
+		tlm_<N> directory.
+		Concurrent access from multiple user-space processes is allowed.
+		The kernel does not enforce exclusivity or ownership of the
+		interface.
+		All configuration changes are applied immediately by issuing
+		the related SCMI commands. Writes to different attributes may
+		interleave and no atomicity across multiple files is guaranteed.
+		In case of concurrent writes to the same attribute, the last
+		writer wins.
+		Read operations may observe state that has been already modified
+		and it is stale.
+		Userspace is responsible for coordinating access if stronger
+		consistency or serialization is required and this filesystem
+		provides a generation counter to aid in the detection of sudden
+		configuration changes.
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/all_des_enable
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry to enable all the discovered Data Events for
+		SCMI instance <N>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/all_tstamp_des_enable
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry to enable timestamps for all the discovered
+		Data Events for SCMI instance <N>. (when available)
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/available_update_intervals_ms
+Date:		Nov 2026
+KernelVersion:	7.3
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
+What:		/sys/fs/arm_telemetry/tlm_<N>/by-components/
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A subdirectory that exposes an alternative topological view of
+		the same set of discovered DEs that can be already found under
+		the des/ branch.
+		This topology subtree is built following this structure:
+		    by-components/
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
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	An RW entry that can be used to discover, configure and retrieve
+		Telemetry data using the alternative binary interface based on
+		ioctls which is documented in include/uapi/linux/scmi.h
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/current_update_intervals_ms
+Date:		Nov 2026
+KernelVersion:	7.3
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
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a string representing the 128bit UUID
+		that uniquely identifies the set of SCMI Telemetry Data Events
+		and their semantic for SCMI instance <N>.
+		This is compliant with the DE_IMPLEMENTATION_REVISION described
+		in SCMI v4.0 Telemetry 3.12.4.3.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des_bulk_read
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns a multi-line string containing all the
+		the DEs enabled for SCMI instance <N>, one-per-line, formatted
+		as: <DE_ID> <TIMESTAMP> <DATA_VALUE>
+		These DEs readings represent the last value updated by the
+		platform following the configured update interval: on the
+		backend they will have been collected transparently in a number
+		of different ways: on-demand SHMTI lookup, notifications,
+		fastchannels. Data consistency is guaranteed by the underlying
+		SCMI synchronization mechanisms.
+		Any disabled or unavailable DE is simply NOT included.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des_single_sample_read
+Date:		Nov 2026
+KernelVersion:	7.3
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
+What:		/sys/fs/arm_telemetry/tlm_<N>/generation
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that returns an integer representing the number of
+		configuration changes applied using any entry in this interface:
+		any read, following the first one after the open, blocks until
+		the next configuration change is applied and the counter is
+		increased: this entry supports poll/select system calls to ease
+		the monitoring process.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/intervals_discrete
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean RO entry to specify if the intervals reported for
+		SCMI instance <N> in available_update_intervals_ms are a list of
+		discrete intervals or a triplet of values representing
+		<LOWEST_UPDATE_INTERVAL> <HIGHEST_UPDATE_INTERVAL> <STEP_SIZE>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/reset
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean WO entry that can be used the full reset of the SCMI
+		Telemetry subsystem, both of the configurations and of the
+		collected data, as specified in SCMI v4.0 3.12.4.12
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/tlm_enable
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean RW entry that can be used to get or set the general
+		enable status of the Telemetry subsystem. Temporarily disabling
+		Telemetry as a whole does NOT reset the current configuration,
+		it only stops all the configured DEs updates platform side.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/version
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry used to report the SCMI Telemetry protocol version
+		used in this implementation.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/compo_instance_id
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the component instance to which this DE
+		belongs, as described by the DataEvent Descriptor in SCMI v4.0
+		3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/compo_type
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the component type to which this DE is
+		associated, as described by the DataEvent Descriptor in SCMI v4.0
+		3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/instance_id
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the DE instance ID that identifies this DE
+		within the component instance to which it belongs, as described
+		by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/name
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A optional RO entry to report the name associated with this DE,
+		as described by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/persistent
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO boolean to report that the DE data values are persistent
+		across all reboot cycles, except cold reboot, as described by
+		the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/tstamp_rate
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	An optional RO entry to report the clock rate in KHZ used to
+		generate the timestamps associated to this DE, as described by
+		the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/type
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the type of DataEvent as described by the
+		DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/unit
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the unit of measurements used by this DE,
+		as described by the DataEvent Descriptor in SCMI v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/unit_exp
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry to report the power-of-10 multiplier in two's
+		complement format that is applied to the unit specified by the
+		DE unit field, as described by the DataEvent Descriptor in SCMI
+		v4.0 3.12.4.6.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/value
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry used to read the last value and timestamp collected
+		for Data Event with id	0x<NNNNNNNN> for SCMI instance <N>.
+		The output is formatted as: <TIMESTAMP> <DATA_VALUE>
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
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RW boolean entry used to enable or disable Data Event
+		with id	0x<NNNNNNNN> for SCMI instance <N>.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/des/0x<NNNNNNNN>/tstamp_enable
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	An RW boolean entry used to enable or disable timestamping for
+		Data Event with id 0x<NNNNNNNN> for SCMI instance <N>.
+		This entry is optional and present only if the DE supports
+		timestamping.
+Users:		Any userspace telemetry tool
+
+What:		/sys/fs/arm_telemetry/tlm_<N>/groups/<M>/
+Date:		Nov 2026
+KernelVersion:	7.3
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
+Date:		Nov 2026
+KernelVersion:	7.3
+Contact:	cristian.marussi@arm.com
+Description:	A RO entry that reports the space separated list of DataEvents
+		belonging to group <M> for SCMI instance <N>
+Users:		Any userspace telemetry tool
-- 
2.54.0

