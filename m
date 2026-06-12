Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0A364022;
	Fri, 12 Jun 2026 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303918; cv=none; b=hcZ5CLkkZsCkQalCGm0WEIDpMBdg00OWWpjKgBPL6Rc+GCc7XcuxEbJ3R/QxOP1Fsg7ySiAp7nOaO0phUFbPsNFpyFg9tJh8oy5yiVFmq1kiccucj229L1AlwRjGhij4YI5FgjCh14ZKn1x4tVhieK8JW/31uU+yv/9d4Nfx6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303918; c=relaxed/simple;
	bh=x5vo2j5gyAO3KY5BoQQecUaPfbPxmhUlg6nEtl+WmBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q0rTdtDeNj/stkjjlwN+I4qTdgiHpFZ7Axd4Jw9WBsqDpMCCzZ6hQ3SoNr2pbPUc4ywrYbDmG6WdLMoYc3O60s9oUV6meKhlw2Ql/Z9DlGhvOyc0DpgdLJSLZhmFXYDEFh+zeimq1JM+G1c8O3AlSusd6jRt1j3iiqU8rn9pyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G8g2/O1K; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G8g2/O1K"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC4C53543;
	Fri, 12 Jun 2026 15:38:29 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDF73FB7F;
	Fri, 12 Jun 2026 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303914; bh=x5vo2j5gyAO3KY5BoQQecUaPfbPxmhUlg6nEtl+WmBA=;
	h=From:To:Cc:Subject:Date:From;
	b=G8g2/O1KI9NYR2hfQtDS5sdPX+vAB0SDsmYi1bp14mIvvQ5lIFgn5Kny/IoOSR/xi
	 S+QiekVXOdn0X6XiMaCmrDZlsQjTKT/oxKiCxU0Bk794Q/DQuo3rgEA/ZQLY9eJPkr
	 dmyxseolQUKuquoJqQ0h0Irepwy/aRT+ls9zN5QQ=
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
Subject: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
Date: Fri, 12 Jun 2026 23:37:30 +0100
Message-ID: <20260612223802.1337232-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

--------------------------------------------------------------------------------
[TLDR Summary]
This series introduces a new SCMI driver which uses a new Telemetry FS to expose
and configure SCMI Telemetry Data Events retrieved from the platform SCMI FW
at runtime. The patches carrying the new STLMFS Filesystem support are tagged
with 'stlmfs'.
--------------------------------------------------------------------------------

the upcoming SCMI v4.0 specification [0] introduces a new SCMI protocol
dedicated to System Telemetry.

In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
runtime the set of Telemetry Data Events (DEs) available on a specific
platform and provides the means to configure the set of DEs that a user is
interested into, while reading them back using the collection method that
is deeemed more suitable for the usecase at hand. (...amongst the various
possible collection methods allowed by SCMI specification)

Without delving into the gory details of the whole SCMI Telemetry protocol
let's just say that the SCMI platform/server firmware advertises a number
of Telemetry Data Events, each one identified by a 32bit unique ID, and an
SCMI agent/client, like Linux, can discover them and read back at will the
associated data value in a number of ways.
Data collection is mainly intended to happen on demand via shared memory
areas exposed by the platform firmware, discovered dynamically via SCMI
Telemetry and accessed by Linux on-demand, but some DE can also be reported
via SCMI Notifications asynchronous messages or via direct dedicated
FastChannels (another kind of SCMI memory based access): all of this
underlying mechanism is anyway hidden to the user since it is mediated by
the kernel driver which will return the proper data value when queried.

Anyway, the set of well-known architected DE IDs defined by the spec is
limited to a dozen IDs, which means that the vast majority of DE IDs are
customizable per-platform: as a consequence, though, the same ID, say
'0x1234', could represent completely different things on different systems.

Precise definitions and semantic of such custom Data Event IDs are out of
the scope of the SCMI Telemetry specification and of this implementation:
they are supposed to be provided using some kind of JSON-like description
file that will have to be consumed by a userspace tool which would be
finally in charge of making sense of the set of available DEs.

IOW, in turn, this means that even though the DEs enumerated via SCMI come
with some sort of topological and qualitative description provided by the
protocol (like unit of measurements, name, topology info etc), kernel-wise
we CANNOT be completely sure of "what is what" without being fed-back some
sort of information about the DEs by the afore mentioned userspace tool.

For these reasons, currently this series does NOT attempt to register any
of these DEs with any of the usual in-kernel subsystems (like HWMON, IIO,
PERF etc), simply because we cannot be sure which DE is suitable, or even
desirable, for a given subsystem. This also means there are NO in-kernel
users of these Telemetry data events as of now.

So, while we do not exclude, for the future, to feed/register some of the
discovered DEs to/with some of the above mentioned Kernel subsystems, as
of now we have ONLY modeled a custom userspace API to make SCMI Telemetry
available to userspace tools.

In deciding which kind of interface to expose SCMI Telemetry data to a
user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:

 - exposing an FS-based human-readable interface that can be used to
   discover, configure and access our Telemetry data directly also from
   the shell without special tools

 - exposing alternative machine-friendly, more-performant, binary
   interfaces that can be used to avoid the overhead of multiple accesses
   to the VFS and that can be more suitable to access with custom tools

In the initial RFC posted a few months ago [1], the above was achieved
with a combination of a SysFS interface, for the human-readable side of
the story, and a classic chardev/ioctl for the plain binary access.

Since V1, instead, we moved away from this combined approach, especially
away from SysFS, for the following reason:

 1. "Abusing SysFS": SysFS is a handy way to expose device related
      properties in a common way, using a few common helpers built on
      kernfs; this means, though, that unfortunately in our scenario I had
      to generate a dummy simple device for EACH SCMI Telemetry DataEvent
      that I got to discover at runtime and attach to them, all of the
      properties I need.
      This by itself seemed to me abusing the SysFS framework, but, even
      ignoring this, the impact on the system when we have to deal with
      hundreds or tens of thousands of DEs is sensible.
      In some test scenario I ended with 50k DE devices and half-a-millon
      related property files ... O_o

 2. "SysFS constraints": SysFS usage itself has its well-known constraints
      and best practices, like the one-file/one-value rule, and due to the
      fact that any virtual file with a complex structure or handling logic
      is frowned upon, you can forget about IOCTLs and mmap'ing to provide
      a more performant interface within SysFs, which is the reason why,
      in the previous RFC, there was an additional alternative chardev
      interface.
      These latter limitations around the implementation of files with a
      more complex semantic (i.e. with a broader set of file_operations)
      derive from the underlying KernFS support, so KernFS is equally not
      suitable as a building block for our implementation.

 2. "Chardev limitations": Given the nature of the protocol, the hybrid
      approach employing character devices was itself problematic: first
      of all because there is an upper limit on the number of chardev we
      can create, dictated by the range of available minor numbers, and
      then because the fact itself to have to maintain 2 completely
      different interfaces (FS + chardev) is painful.

As a final remark, please NOTE THAT all of this is supposed to be available
in production systems across a number of heterogeneous platforms: for these
reasons the easy choice, debugFS, is NOT an option here.

Due to the above reasoning, since V1 we opted for a new approach with the
proposed interfaces now based on a full fledged, unified, virtual pseudo
filesystem implemented from scratch, so that we can:

 - expose all the DEs property we like as before with SysFS, but without
   any of the constraint imposed by the usage of SysFs or kernfs.

 - easily expose additional alternative views of the same set of DEs
   using symlinking capabilities (e.g. alternative topological view)

 - additionally expose a few alternative and more performant interfaces
   by embedding in that same FS, a few special virtual files:

   + 'control': to issue IOCTLs for quicker discovery and on-demand access
   		to data
   + 'pipe' [TBD]: to provide a stream of events using a virtual
   		   infinite-style file
   + 'raw_<N>' [TBD]: to provide direct memory mapped access to the raw
   		      SCMI Telemetry data from userspace

 - use a mount option to enable a lazy enumeration operation mode to delay
   SCMI related background discovery activities to the effective point in
   time when the user needs it (if ever) so as to mitigate the effect at
   boot-time of the initial SCMI full discovery process


INTERFACES
===========

We propose a couple of interfaces, both rooted in the same unified
SCMI Telemetry Filesystem STLMFS, which can be mounted with:

	mount -t stlmfs none /sys/fs/arm_telemetry/

The new pseudo FS rationale, design and related ABI interface is documented
in detail at:

 - Documentation/filesystems/stlmfs.rst
 - Documentation/ABI/testing/stlmfs

...anyway, roughly, STLMFS exposes the following interfaces, rooted at
different points in the FS:

 1. a FS based human-readable API tree

   This API present the discovered DEs and DEs-groups rooted under a
   structrure like this:

	/sys/fs/arm_telemetry/tlm_0/
	|-- all_des_enable
	|-- all_des_tstamp_enable
	|-- available_update_intervals_ms
	|-- current_update_interval_ms
	|-- de_implementation_version
	|-- des
	|   |-- 0x00000000/
	|   |-- 0x00000016/
	|   |-- 0x00001010/
	|   |-- 0x0000A000/
	|   |-- 0x0000A001/
	|   |-- 0x0000A002/
	|   |-- 0x0000A005/
	|   |-- 0x0000A007/
	|   |-- 0x0000A008/
	|   |-- 0x0000A00A/
	|   |-- 0x0000A00B/
	|   |-- 0x0000A00C/
	|   `-- 0x0000A010/
	|-- des_bulk_read
	|-- des_single_sample_read
	|-- groups
	|   |-- 0/
	|   `-- 1/
	|-- intervals_discrete
	|-- reset
	|-- tlm_enable
	`-- version

	At the top level we have general configuration knobs to:

	- enable/disable all DEs with or without tstamp
	- configure the update interval that the platform will use
	- enable Telemetry as a whole
	- read all the enabled DEs in a buffer one-per-line
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
	- des_single_sample_read to request an immediate updated read of
	  all the enabled DEs in a single buffer one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
        
	where each DE in turn is represented by a flat subtree like:

	tlm_0/des/0x0000A001/
	|-- compo_instance_id
	|-- compo_type
	|-- enable
	|-- instance_id
	|-- name
	|-- persistent
	|-- tstamp_enable
	|-- tstamp_exp
	|-- type
	|-- unit
	|-- unit_exp
	`-- value

	where, beside a bunch of description items, you can:

	- enable/disable a single DE
	- read back its tstamp and data from 'value' as in:
		<TIMESTAMP>: <DATA_VALUE>

	then for each (optionally) discovered group of DEs:

	scmi_tlm_0/groups/0/
	|-- available_update_intervals_ms
	|-- composing_des
	|-- current_update_interval_ms
	|-- des_bulk_read
	|-- des_single_sample_read
	|-- enable
	|-- intervals_discrete
	`-- tstamp_enable

	you can find the knobs to:
	
	- enable/disable the group as a whole
	- lookup group composition
	- set a per-group update interval (if supported)
	- des_bulk_read to read all the enabled DEs for this group in a
	  single buffer one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
	- des_single_sample_read to request an immediate updated read of
	  all the enabled DEs for this group in a single buffer
	  one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>

 2. Leveraging the capabilities offered by the full-fledged filesystem
    implementation and the topological information provided by SCMI
    Telemetry we expose also and alternative view of the above tree, by
    symlinking a few of the same entries above under another, topologically
    sorted, subtree:


        by-components/                                                           
        ├── cpu                                                                  
        │   ├── 0                                                                
        │   │   ├── celsius                                                      
        │   │   │   └── 0                                                        
        │   │   │       └── 0x00000001[pe_0] -> ../../../../../des/0x00000001    
        │   │   └── cycles                                                       
        │   │       ├── 0                                                        
        │   │       │   └── 0x00001010[] -> ../../../../../des/0x00001010        
        │   │       └── 1                                                        
        │   │           └── 0x00002020[] -> ../../../../../des/0x00002020        
        │   ├── 1                                                                
        │   │   └── celsius                                                      
        │   │       └── 0                                                        
        │   │           └── 0x00000002[pe_1] -> ../../../../../des/0x00000002    
        │   └── 2                                                                
        │       └── celsius                                                      
        │           └── 0                                                        
        │               └── 0x00000003[pe_2] -> ../../../../../des/0x00000003    
        ├── interconnnect                                                        
        │   └── 0                                                                
        │       └── hertz                                                        
        │           └── 0                                                        
        │               ├── 0x0000A008[A008_de] -> ../../../../../des/0x0000A008 
        │               └── 0x0000A00B[] -> ../../../../../des/0x0000A00B        
        ├── mem_cntrl                                                            
        │   └── 0                                                                
        │       ├── bps                                                          
        │       │   └── 0                                                        
        │       │       └── 0x0000A00A[] -> ../../../../../des/0x0000A00A        
        │       ├── celsius                                                      
        │       │   └── 0                                                        
        │       │       └── 0x0000A007[DRAM_temp] -> ../../../../../des/0x0000A007
        │       └── joules                                                       
        │           └── 0                                                        
        │               └── 0x0000A002[DRAM_energy] -> ../../../../../des/0x0000A002
        ├── periph                                                               
        │   ├── 0                                                                
        │   │   └── messages                                                     
        │   │       └── 0                                                        
        │   │           └── 0x00000016[device_16] -> ../../../../../des/0x00000016
        │   ├── 1                                                                
        │   │   └── messages                                                     
        │   │       └── 0                                                        
        │   │           └── 0x00000017[device_17] -> ../../../../../des/0x00000017
        │   └── 2                                                                
        │       └── messages                                                     
        │           └── 0                                                        
        │               └── 0x00000018[device_18] -> ../../../../../des/0x00000018
        └── unspec                                                               
                └── 0                                                            
                    ├── celsius                                                  
                    │   └── 0                                                    
                    │       └── 0x0000A005[] -> ../../../../../des/0x0000A005    
                    ├── counts                                                   
                    │   └── 0                                                    
                    │       └── 0x0000A00C[] -> ../../../../../des/0x0000A00C    
                    ├── joules                                                   
                    │   └── 0                                                    
                    │       ├── 0x0000A000[SOC_Energy] -> ../../../../../des/0x0000A000
                    │       └── 0x0000A001[] -> ../../../../../des/0x0000A001    
                    └── state                                                    
                        └── 0                                                    
                            └── 0x0000A010[] -> ../../../../../des/0x0000A010    
                                                                                 
  ...so as to provide the human user with a more understandable topological
  layout of the madness...

All of this is nice and fancy human-readable, easily scriptable, but
certainly not the fastest possible to access especially on huge trees...

 ... so for the afore-mentioned reasons we alternatively expose

 3. a more performant API based on IOCTLs as described fully in:

	include/uapi/linux/scmi.h

   As described succinctly in the above UAPI header too, this API is meant
   to be called on a few special files named 'control' that are populated
   into the tree:

   .
   |-- all_des_enable
   .....
   |-- components
   |   |-- cpu
   |   |-- interconnnect
   |   |-- mem_cntrl
   |   |-- periph
   |   `-- unspec
   |-- control
   .....................

   |-- groups
   |   |-- 0
   |   |   |-- available_update_intervals_ms
   |   |   |-- composing_des
   |   |   |-- control
   .....................
   |   |-- 1
   |   |   |-- available_update_intervals_ms
   |   |   |-- composing_des
   |   |   |-- control
   .....................
   |   `-- 2
   |       |-- available_update_intervals_ms
   |       |-- composing_des
   |       |-- control
   .....................

  This allows a tool to:

   - use some IOCTLs to configure a set of properties equivalent to the
     ones above in FS
   - use some other IOCTLs for direct access to data in binary format
     for a single DEs or all of them

 4. [FUTURE/NOT IN THIS SERIES]
    Add another alternative, completely binary, direct raw accessbinterface
    via a new set of memory mappable special files so as to allow userspace
    tools to access SCMI Telemetry data directly in binary form without any
    kernel mediation.

NOTE THAT this series, at the firmware interface level NOW supports ONLY
the latest SCMI v4.0 specification [0].

Missing feats & future steps
----------------------------
 - add direct access interface via mmap-able 'raw' files
 - add streaming mode interface via 'pipe' file (tentative)
 - evolve/enhance app in tools/testing/scmi/stlm to be interactive

KNOWN ISSUES
------------
 - STLMFS code layout and location...nothing lives in fs/ and no distinct
   FS Kconfig...but the SCMI Telemetry driver itself has no point in existing
   without the FS that exposes...so should I split the pure FS part into fs/
   anyway or not ?
 - residual sparse/smatch static analyzers errors
 - stlm tool utility is minimal for testing or development

Based on V7.1-rc7, tested on an emulated setup.

This series is available also at [2].

If you still reading...any feedback welcome :P

Thanks,
Cristian

----
v3 --> v4
 - rebased on v7.1-rc7
 - updatded doc to detail Concurrency model
 - bail out on FW_BUG errors
 - make all_des_enable/all_des_tstamp_enable entry readable
 - refactored access to TDE values
 - refactored common accessors for tlm_priv (FIX WARN on kfree)
 - make all files by default world readable and user writable (if needed)
 - added uid/god/umask mount options (and docs)
 - added generation counter to aid spotting config changes (and docs)
 - added DebugFS configurable support to debug/dump SHMTI areas (and docs)
 - hide FS entries when NOT supported (like des_simple_sample_read)
 - fixed output format of des/<NNN>/value to -> <TS> <VALUE>
 - renamed top-dir by_components to by-components
 - add a .remove method to SCMI System Telemetry Driver
 - use kzalloc_obj
V2 --> V3
 - rebased on v7.0-rc5
 - ported the firmware interface to SCMI v4.0 BETA
 - split the SCMI protocol layer in a lot of small patches
 - completd filesystem and ABI documentation
 - renamed components subtree to by_components
 - fixed uninitialized var in scmi_telemetry_de_subdir_symlink
 - renamd tstamp_exp to tstamp_rate
 - swap logic in scmi_telemetry_initial_state_lookup
 - use memcpy_from_le32 where required
 - changed a dfew dev_err into Telemetry traces
 - define and use new helper scmi_telemetry_de_unlink
 - simplify a few assignments with ternary ops
 - added a missing __mmust_check on the internal SCMI API
 - reworked and clarified de_data_read returned errno:
 	ENODATA vs EINVAL vs ENODEV/ENOENT
 - removed some risky/unneeded devres allocations
 - various checkpatch fixes
 - reworked and clarified usage of traces in Telemetry
 - added the missing DT binding for protocol 0x1B
 - split out unrelated change around notification from patch
   adding support for protocol internal notifier
 - more comments

V1 --> V2
 - rebased on v6.19-rc3
 - harden TDCF shared memory areas accesses by using proper accessors
 - reworked protocol resources lifecycle to allow lazy enumeration
 - using NEW FS mount API
 - reworked FS inode allocation to use a std kmem_cache
 - fixed a few IOCTLs support routine to support lazy enumeration
 - added (RFC) a new FS lazy mount option to support lazily population of
   some subtrees of the FS (des/ groups/ components/)
 - reworked implementation of components/ alternative FS view to use
   symlinks instead of hardlinks
 - added a basic simple (RFC) testing tool to exercise UAPI ioctls interface
 - hardened Telmetry protocol and driver to support partial out-of-spec FW
   lacking some cmds (best effort)
 - reworked probing races handling
 - reviewed behaviour on unmount/unload
 - added support for Boot_ON Telemetry by supporting SCMI Telemetry cmds:
   + DE_ENABLED_LIST
   + CONFIG_GET
 - added FS and ABI docs

RFC --> V1
---
 - moved from SysFS/chardev to a full fledged FS
 - added support for SCMI Telemetry BLK timestamps


Thanks,
Cristian

[0]: https://developer.arm.com/documentation/den0056/f/?lang=en
[1]: https://lore.kernel.org/arm-scmi/20250620192813.2463367-1-cristian.marussi@arm.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cris/linux.git/log/?h=scmi_telemetry_unified_fs_V4

Cristian Marussi (31):
  firmware: arm_scmi: Add new SCMIv4.0 error codes definitions
  firmware: arm_scmi: Reduce the scope of protocols mutex
  firmware: arm_scmi: Allow registration of unknown-size events/reports
  firmware: arm_scmi: Allow protocols to register for notifications
  uapi: Add ARM SCMI definitions
  dt-bindings: firmware: arm,scmi: Add support for telemetry protocol
  include: trace: Add Telemetry trace events
  firmware: arm_scmi: Add basic Telemetry support
  firmware: arm_scmi: Add support to parse SHMTIs areas
  firmware: arm_scmi: Add Telemetry configuration operations
  firmware: arm_scmi: Add Telemetry DataEvent read capabilities
  firmware: arm_scmi: Add support for Telemetry reset
  firmware: arm_scmi: Add Telemetry notification support
  firmware: arm_scmi: Add support for boot-on Telemetry
  firmware: arm_scmi: Add Telemetry generation counter
  firmware: arm_scmi: Add common per-protocol debugfs support
  firmware: arm_scmi: Add Telemetry debugfs SHMTI dump support
  firmware: arm_scmi: Add Telemetry debugfs ABI documentation
  firmware: arm_scmi: stlmfs: Add System Telemetry filesystem driver
  fs/stlmfs: Document ARM SCMI Telemetry filesystem
  firmware: arm_scmi: stlmfs: Add basic mount options
  fs/stlmfs: Document ARM SCMI Telemetry FS mount options
  firmware: arm_scmi: stlmfs: Add ioctls support
  fs/stlmfs: Document alternative ioctl based binary interface
  firmware: arm_scmi: stlmfs: Add by-components view
  fs/stlmfs: Document alternative topological view
  firmware: arm_scmi: stlmfs: Add generation file
  [RFC] docs: stlmfs: Document ARM SCMI Telemetry FS ABI
  firmware: arm_scmi: stlmfs: Add lazy population support
  fs/stlmfs: Document lazy mode and related mount option
  [RFC] tools/scmi: Add SCMI Telemetry testing tool

 Documentation/ABI/testing/debugfs-scmi        |   22 +
 Documentation/ABI/testing/stlmfs              |  348 ++
 .../bindings/firmware/arm,scmi.yaml           |    8 +
 Documentation/filesystems/stlmfs.rst          |  342 ++
 MAINTAINERS                                   |    1 +
 drivers/firmware/arm_scmi/Kconfig             |   24 +
 drivers/firmware/arm_scmi/Makefile            |    3 +-
 drivers/firmware/arm_scmi/common.h            |   10 +
 drivers/firmware/arm_scmi/driver.c            |   93 +-
 drivers/firmware/arm_scmi/notify.c            |   30 +-
 drivers/firmware/arm_scmi/notify.h            |    8 +-
 drivers/firmware/arm_scmi/protocols.h         |   13 +
 .../firmware/arm_scmi/scmi_system_telemetry.c | 3146 ++++++++++++++++
 drivers/firmware/arm_scmi/telemetry.c         | 3300 +++++++++++++++++
 include/linux/scmi_protocol.h                 |  203 +-
 include/trace/events/scmi.h                   |   48 +-
 include/uapi/linux/scmi.h                     |  289 ++
 tools/testing/scmi/Makefile                   |   25 +
 tools/testing/scmi/stlm.c                     |  434 +++
 19 files changed, 8307 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/ABI/testing/stlmfs
 create mode 100644 Documentation/filesystems/stlmfs.rst
 create mode 100644 drivers/firmware/arm_scmi/scmi_system_telemetry.c
 create mode 100644 drivers/firmware/arm_scmi/telemetry.c
 create mode 100644 include/uapi/linux/scmi.h
 create mode 100644 tools/testing/scmi/Makefile
 create mode 100644 tools/testing/scmi/stlm.c

-- 
2.54.0

